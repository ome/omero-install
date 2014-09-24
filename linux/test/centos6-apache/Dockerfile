# Dockerfile for testing the OMERO Linux installation instructions
# Not intended for production use
FROM centos:centos6
MAINTAINER ome-devel@lists.openmicroscopy.org.uk

# Needed for postgres init.d
RUN touch /etc/sysconfig/network

ADD omero-install-test.zip /
RUN yum -y install unzip && unzip omero-install-test.zip

RUN cd omero-install-test && bash install-centos6-apache.sh
ADD run.sh /home/omero/run.sh

EXPOSE 80 4063 4064
CMD ["/bin/bash", "-e", "/home/omero/run.sh"]
