FROM lsiobase/alpine.python:3.5
MAINTAINER smdion <me@seandion.com> ,sparklyballs

# install packages
RUN \
 apk add --no-cache \
	ffmpeg \
	mc \
	openssl

# install build packages
RUN \
 apk add --no-cache --virtual=build-dependencies \
 	g++ \
	gcc \
	make && \

# compile shntool
 mkdir -p \
	/tmp/shntool && \
 curl -o \
 /tmp/shntool-src-tar.gz -L \
	http://www.etree.org/shnutils/shntool/dist/src/shntool-3.0.10.tar.gz && \
 tar xf /tmp/shntool-src-tar.gz -C \
	/tmp/shntool --strip-components=1 && \
 cd /tmp/shntool && \
 ./configure \
	--infodir=/usr/share/info \
	--localstatedir=/var \
	--mandir=/usr/share/man \
	--prefix=/usr \
	--sysconfdir=/etc && \
 make && \
 make install && \

# cleanup
 apk del --purge \
	build-dependencies && \
 rm -rf \
	/tmp/* \
	/usr/lib/*.la

# add local files
COPY root/ /

# ports and volumes
EXPOSE 8181
VOLUME /config /downloads /music
