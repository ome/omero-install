# Dockerfile for testing the OMERO Linux installation instructions
# Not intended for production use
# Note to enable systemd this must be run with on a host with systemd
# and additional flaks, see the omero-ssh-c7 README
FROM openmicroscopy/omero-ssh-c7:0.1.0-1

MAINTAINER ome-devel@lists.openmicroscopy.org.uk

# Remove the existing omero user
RUN userdel -r omero && \
	rm -f /etc/sudoers.d/omero && \
	echo 'root:omero' | chpasswd

ADD omero-install-test.zip /
RUN yum -y install initscripts unzip && unzip omero-install-test.zip

# This is so that scripts can detect whether they're in docker
RUN echo 'export container=docker' > /etc/profile.d/docker.sh

ARG WEBSESSION=false
ARG WEBAPPS=false
ARG OMEROVER=latest
ARG JAVAVER=openjdk18
ARG ICEVER=ice36
ARG PGVER=pg94

RUN cd omero-install-test && \
	bash install_centos7_apache24.sh

EXPOSE 22 80 4063 4064
