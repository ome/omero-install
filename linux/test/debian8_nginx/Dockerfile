# Dockerfile for testing the OMERO Linux installation instructions
# Not intended for production use
FROM debian:jessie
MAINTAINER ome-devel@lists.openmicroscopy.org.uk

ARG WEBAPPS=false
ARG OMEROVER=omero
ARG JAVAVER=openjdk18
ARG ICEVER=ice35
ARG PGVER=pg94

RUN apt-get update && apt-get -y install locales
RUN update-locale LANG=C.UTF-8

ADD omero-install-test.zip /
RUN apt-get -y install unzip && unzip omero-install-test.zip

RUN cd omero-install-test && \
	bash install_debian8_nginx.sh && \
	bash docker_shutdown_ubuntu1404.sh
ADD run.sh /home/omero/run.sh

EXPOSE 80 4063 4064
CMD ["/bin/bash", "-e", "/home/omero/run.sh"]
