# Dockerfile for testing the OMERO Linux installation instructions
# Not intended for production use
FROM fedora:30
MAINTAINER ome-devel@lists.openmicroscopy.org.uk

ARG WEBSESSION=false
ARG OMEROVER=latest
ARG JAVAVER=openjdk1.8
ARG ICEVER=ice36
ARG PGVER=pg10

ENV LANG en_US.UTF-8
ENV container docker
#RUN echo 'export container=docker' > /etc/profile.d/docker.sh

ADD omero-install-test.zip /
RUN yum -y install unzip && unzip omero-install-test.zip

RUN cd omero-install-test && \
	bash install_fedora30_nginx.sh

ADD run.sh /home/omero/run.sh

EXPOSE 80 4063 4064
CMD ["/bin/bash", "-e", "/home/omero/run.sh"]
