# Dockerfile for testing the OMERO Linux installation instructions
# Not intended for production use
FROM rockylinux:9
MAINTAINER ome-devel@lists.openmicroscopy.org.uk

ARG OMEROVER=latest
ARG JAVAVER=openjdk11
ARG ICEVER=ice36
ARG PGVER=pg13

RUN touch /.dockerenv
ADD omero-install-test.zip /
RUN dnf -y install unzip && unzip omero-install-test.zip

RUN cd omero-install-test && \
	bash install_rocky9.sh

ADD run.sh /home/omero-server/run.sh

EXPOSE 80 4063 4064
CMD ["/bin/bash", "-e", "/home/omero-server/run.sh"]
