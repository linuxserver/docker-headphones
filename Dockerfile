FROM linuxserver/baseimage
MAINTAINER smdion <me@seandion.com>
ENV LC_ALL C.UTF-8
ENV LANG en_US.UTF-8


# Use baseimage-docker's init system
CMD ["/sbin/my_init"]

# Install Dependencies
RUN add-apt-repository ppa:mc3man/trusty-media && \
apt-get update && \
apt-get install -qy git mc ffmpeg python wget && \
apt-get clean && rm -rf /var/lib/apt/lists/* /var/tmp/*

#Adding Custom files
ADD init/ /etc/my_init.d/
ADD services/ /etc/service/
ADD defaults/ /defaults
RUN chmod -v +x /etc/service/*/run
RUN chmod -v +x /etc/my_init.d/*.sh
 
#Volumes and Ports
EXPOSE 8181
VOLUME ["/config", "/downloads", "/music"]


