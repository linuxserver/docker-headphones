# syntax=docker/dockerfile:1

FROM ghcr.io/linuxserver/baseimage-alpine:3.17

# set version label
ARG BUILD_DATE
ARG VERSION
ARG HEADPHONES_COMMIT
LABEL build_version="Linuxserver.io version:- ${VERSION} Build-date:- ${BUILD_DATE}"
LABEL maintainer="aptalca"
# hard set UTC in case the user does not define it
ENV TZ="Etc/UTC"

# copy patches folder
COPY patches/ /tmp/patches/

RUN \
  echo "**** install build packages ****" && \
  apk add --no-cache --virtual=build-dependencies \
    build-base && \
  echo "**** install runtime packages ****" && \
  apk add --no-cache \
    ffmpeg \
    flac \
    mc \
    python3 && \
  echo "**** compile shntool *** *" && \
  mkdir -p \
    /tmp/shntool && \
  tar xf /tmp/patches/shntool-3.0.10.tar.gz -C \
    /tmp/shntool --strip-components=1 && \
  cp /tmp/patches/config.* /tmp/shntool && \
  cd /tmp/shntool && \
  ./configure \
    --infodir=/usr/share/info \
    --localstatedir=/var \
    --mandir=/usr/share/man \
    --prefix=/usr \
    --sysconfdir=/etc && \
  make && \
  make install && \
  echo "**** install headphones ****" && \
  mkdir -p /app/headphones && \
  if [ -z ${HEADPHONES_COMMIT+x} ] ; then \
    HEADPHONES_COMMIT=$(curl -sX GET "https://api.github.com/repos/rembo10/headphones/commits/master" \
    | jq -r .sha); \
  fi && \
  curl -o \
    /tmp/headphones.tar.gz -sL \
    "https://github.com/rembo10/headphones/archive/${HEADPHONES_COMMIT}.tar.gz" && \
  tar xf \
    /tmp/headphones.tar.gz -C \
    /app/headphones --strip-components=1 && \
  echo ${HEADPHONES_COMMIT} > /app/headphones/version.txt && \
  echo "**** cleanup ****" && \
  apk del --purge \
    build-dependencies && \
  rm -rf \
    /tmp/* \
    /usr/lib/*.la

# add local files
COPY root/ /

# ports and volumes
EXPOSE 8181
VOLUME /config
