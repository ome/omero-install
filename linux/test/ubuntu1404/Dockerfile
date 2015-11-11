# Dockerfile for testing the OMERO Linux installation instructions
# Not intended for production use
FROM ubuntu:14.04
MAINTAINER ome-devel@lists.openmicroscopy.org.uk

RUN update-locale LANG=C.UTF-8

COPY omero-install-test /omero-install-test

RUN cd /omero-install-test && bash install-ubuntu1404.sh
COPY run.sh /home/omero/run.sh

EXPOSE 80 4063 4064
CMD ["/bin/bash", "-e", "/home/omero/run.sh"]
