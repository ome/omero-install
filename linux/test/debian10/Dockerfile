# Dockerfile for testing the OMERO Linux installation instructions
# Not intended for production use
FROM debian:buster
MAINTAINER ome-devel@lists.openmicroscopy.org.uk

ENV PATH /opt/conda/bin:$PATH
ARG PATH /opt/conda/bin:$PATH

ARG OMEROVER=latest
ARG JAVAVER=openjdk11
ARG ICEVER=ice36
ARG PGVER=pg10

RUN echo 'APT::Install-Recommends 0;' > /etc/apt/apt.conf.d/01norecommends \
 && echo 'APT::Install-Suggests 0;' >> /etc/apt/apt.conf.d/01norecommends
 
RUN apt-get update && apt-get -y install locales
RUN update-locale LANG=C.UTF-8

ADD omero-install-test.zip /
RUN apt-get -y install unzip wget && unzip omero-install-test.zip

RUN wget --no-check-certificate \
    https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh \
    && mkdir -p /opt \
    && bash Miniconda3-latest-Linux-x86_64.sh -b -p /opt/conda \
    && rm -f Miniconda3-latest-Linux-x86_64.sh \
    && ln -s /opt/conda/etc/profile.d/conda.sh /etc/profile.d/conda.sh \
    && echo ". /opt/conda/etc/profile.d/conda.sh" >> ~/.bashrc


RUN cd omero-install-test && \
	bash install_debian10.sh && \
	bash docker_shutdown_ubuntu.sh
ADD run.sh /home/omero-server/run.sh

EXPOSE 80 4063 4064
CMD ["/bin/bash", "-e", "/home/omero-server/run.sh"]
