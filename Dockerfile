FROM lsiobase/alpine.python:3.8

# set version label
ARG BUILD_DATE
ARG VERSION
ARG HEADPHONES_COMMIT
LABEL build_version="Linuxserver.io version:- ${VERSION} Build-date:- ${BUILD_DATE}"
LABEL maintainer="sparklyballs"

# copy patches folder
COPY patches/ /tmp/patches/

RUN \
 echo "**** install build packages ****" && \
 apk add --no-cache --virtual=build-dependencies \
	g++ \
	gcc \
	jq \
	make && \
 echo "**** install runtime packages ****" && \
 apk add --no-cache \
	ffmpeg \
	flac \
	mc && \
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
 echo "**** install app ****" && \
 if [ -z ${HEADPHONES_COMMIT+x} ]; then \
	HEADPHONES_COMMIT=$(curl -sX GET https://api.github.com/repos/rembo10/headphones/commits/master \
	| jq -r '. | .sha'); \
 fi && \
 mkdir -p /app/headphones && \
 cd /app/headphones && \
 git init && \
 git remote add origin https://github.com/rembo10/headphones.git && \
 git fetch --depth 1 origin ${HEADPHONES_COMMIT} && \
 git checkout FETCH_HEAD && \
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
VOLUME /config /downloads /music
