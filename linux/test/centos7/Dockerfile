# Dockerfile for testing the OMERO Linux installation instructions
# Not intended for production use
# Note to enable systemd this must be run with on a host with systemd
# with the --privileged flag
FROM centos:7
MAINTAINER ome-devel@lists.openmicroscopy.org.uk

# Required for systemd
ENV container docker

ADD omero-install-test.zip /
RUN yum -y install unzip && unzip omero-install-test.zip

RUN cd omero-install-test && bash install-centos7.sh

# PostgreSQL systemd workarounds
RUN sed -i 's/OOMScoreAdjust/#OOMScoreAdjust/' /usr/lib/systemd/system/postgresql.service

EXPOSE 80 4063 4064

# This will automatically start systemd
CMD ["/usr/sbin/init"]
