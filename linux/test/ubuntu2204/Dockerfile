# Dockerfile for testing the OMERO Linux installation instructions
# Not intended for production use
FROM ubuntu:22.04
MAINTAINER ome-devel@lists.openmicroscopy.org.uk

ARG OMEROVER=latest
ARG JAVAVER=openjdk11
ARG ICEVER=ice36
ARG PGVER=pg14

RUN touch /.dockerenv

ENV TZ=Europe/London
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

RUN echo 'APT::Install-Recommends 0;' > /etc/apt/apt.conf.d/01norecommends \
 && echo 'APT::Install-Suggests 0;' >> /etc/apt/apt.conf.d/01norecommends
 
ADD omero-install-test.zip /
RUN apt-get update && apt-get -y install unzip && unzip omero-install-test.zip

RUN cd omero-install-test && \
    bash install_ubuntu2204.sh && \
    bash docker_shutdown_ubuntu.sh
ADD run.sh /home/omero-server/run.sh

EXPOSE 80 4063 4064
CMD ["/bin/bash", "-e", "/home/omero-server/run.sh"]
