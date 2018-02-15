# Dockerfile for testing the OMERO Linux installation instructions
# Not intended for production use
FROM ubuntu:16.04
MAINTAINER ome-devel@lists.openmicroscopy.org.uk

ARG WEBSESSION=false
ARG WEBAPPS=false
ARG OMEROVER=latest
ARG JAVAVER=openjdk18
ARG ICEVER=ice36
ARG PGVER=pg94

RUN echo 'APT::Install-Recommends 0;' > /etc/apt/apt.conf.d/01norecommends \
 && echo 'APT::Install-Suggests 0;' >> /etc/apt/apt.conf.d/01norecommends
 
ADD omero-install-test.zip /
RUN apt-get update && apt-get -y install unzip && unzip omero-install-test.zip

RUN cd omero-install-test && \
	bash install_ubuntu1604_nginx.sh && \
	bash docker_shutdown_ubuntu.sh
ADD run.sh /home/omero/run.sh

EXPOSE 80 4063 4064
CMD ["/bin/bash", "-e", "/home/omero/run.sh"]