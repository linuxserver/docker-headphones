FROM phusion/baseimage:0.9.16
MAINTAINER smdion <me@seandion.com>
RUN rm -rf /etc/service/sshd /etc/my_init.d/00_regen_ssh_host_keys.sh
ENV DEBIAN_FRONTEND noninteractive
ENV HOME            /root
ENV LC_ALL          C.UTF-8
ENV LANG            en_US.UTF-8
ENV TERM screen

# Use baseimage-docker's init system
CMD ["/sbin/my_init"]

# Install Dependencies
RUN add-apt-repository ppa:mc3man/trusty-media
RUN apt-get update


RUN apt-get install -qy git mc ffmpeg python wget
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /var/tmp/*

#Volumes and Ports
EXPOSE 8181
VOLUME /config
VOLUME /downloads
VOLUME /music

#Adding Custom files
ADD init/ /etc/my_init.d/
ADD services/ /etc/service/
ADD defaults/ /defaults
RUN chmod -v +x /etc/service/*/run
RUN chmod -v +x /etc/my_init.d/*.sh
 
#Adduser
RUN useradd -u 911 -U -s /bin/false abc
RUN usermod -G users abc


