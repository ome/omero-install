# Dockerfile for testing the OMERO Linux installation instructions
# Not intended for production use
# Note to enable systemd this must be run with on a host with systemd
# and additional flaks, see the omero-ssh-c7 README
FROM openmicroscopy/omero-ssh-c7:0.1.0-1
MAINTAINER ome-devel@lists.openmicroscopy.org.uk

ENV LANG en_US.UTF-8
ENV PATH /opt/conda/bin:$PATH
ARG PATH /opt/conda/bin:$PATH


# Remove the existing omero user
RUN userdel -r omero && \
    rm -f /etc/sudoers.d/omero && \
    echo 'root:omero' | chpasswd

ADD omero-install-test.zip /
RUN yum update -y
RUN yum -y install ca-certificates
RUN yum -y install initscripts unzip wget && unzip omero-install-test.zip
RUN wget \
    https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh \
    && mkdir -p /opt \
    && bash Miniconda3-latest-Linux-x86_64.sh -b -p /opt/conda \
    && rm -f Miniconda3-latest-Linux-x86_64.sh \
    && ln -s /opt/conda/etc/profile.d/conda.sh /etc/profile.d/conda.sh \
    && echo ". /opt/conda/etc/profile.d/conda.sh" >> ~/.bashrc
RUN conda --version

# This is so that scripts can detect whether they're in docker
RUN echo 'export container=docker' > /etc/profile.d/docker.sh

ARG OMEROVER=latest
ARG JAVAVER=openjdk11
ARG ICEVER=ice36
ARG PGVER=pg11

RUN cd omero-install-test && \
	bash install_centos7.sh

EXPOSE 22 80 4063 4064
