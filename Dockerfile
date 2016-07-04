FROM lsiobase/alpine.python
MAINTAINER smdion <me@seandion.com> ,sparklyballs

# install packages
RUN \
 apk add --no-cache \
	ffmpeg \
	mc && \
 apk add --no-cache --repository \
 http://nl.alpinelinux.org/alpine/edge/testing \
	shntool

# add local files
COPY root/ /

# ports and volumes
EXPOSE 8181
VOLUME ["/config", "/downloads", "/music"]
