# Dockerfile for testing the OMERO Linux installation instructions
# Not intended for production use
# Note to enable systemd this must be run with
#   --cap-add SYS_ADMIN -v /sys/fs/cgroup:/sys/fs/cgroup:ro
FROM centos:7
MAINTAINER ome-devel@lists.openmicroscopy.org.uk

# Setup systemd
ENV container docker
RUN yum -y swap -- remove fakesystemd -- install systemd systemd-libs \
	&& yum clean all && \
	(cd /lib/systemd/system/sysinit.target.wants/; \
	for i in *; do \
	[ $i == systemd-tmpfiles-setup.service ] || rm -f $i; done) && \
	rm -f /lib/systemd/system/multi-user.target.wants/* && \
	rm -f /etc/systemd/system/*.wants/* && \
	rm -f /lib/systemd/system/local-fs.target.wants/* && \
	rm -f /lib/systemd/system/sockets.target.wants/*udev* && \
	rm -f /lib/systemd/system/sockets.target.wants/*initctl* && \
	rm -f /lib/systemd/system/basic.target.wants/* && \
	rm -f /lib/systemd/system/anaconda.target.wants/*
VOLUME ["/sys/fs/cgroup"]


ADD omero-install-test.zip /
RUN yum -y install unzip && unzip omero-install-test.zip

RUN cd omero-install-test && bash install-centos7.sh

# PostgreSQL systemd workarounds
RUN sed -i 's/OOMScoreAdjust/#OOMScoreAdjust/' /usr/lib/systemd/system/postgresql.service

EXPOSE 80 4063 4064

# This will automatically start systemd
CMD ["/usr/sbin/init"]
