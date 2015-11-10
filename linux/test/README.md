Installation walkthroughs
=========================

This directory contains Dockerfiles for testing the installation walkthroughs.

For example:

    ./docker-build.sh ubuntu1404
    docker run -it omero-install-test-ubuntu1404

    ./docker-build.sh centos6
    docker run -it omero-install-test-centos6

Centos 7 cannot be tested in this way as systemd doesn't fully work, see [the Centos 7 README](centos7/README.md).
