# Dockerfile for testing the OMERO Linux installation instructions
# Not intended for production use
# Note to enable systemd this must be run with on a host with systemd
# and additional flaks, see the omero-ssh-systemd README
#FROM openmicroscopy/omero-ssh-systemd
FROM manics/omero-ssh-systemd
MAINTAINER ome-devel@lists.openmicroscopy.org.uk

# Remove the existing omero user
RUN userdel -r omero && \
	rm -f /etc/sudoers.d/omero && \
	echo 'root:omero' | chpasswd

ADD omero-install-test.zip /
RUN yum -y install unzip && unzip omero-install-test.zip

# This is so that scripts can detect whether they're in docker
RUN echo 'export container=docker' > /etc/profile.d/docker.sh

EXPOSE 22 80 4063 4064

# CMD inherited (automatically start systemd)
