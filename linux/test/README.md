Installation walkthroughs
=========================

This directory contains Dockerfiles for testing the installation walkthroughs.

For example:

    ./docker-build.sh ubuntu1404
    docker run -it omero_install_test_ubuntu1404

    ./docker-build.sh centos6
    docker run -it omero_install_test_centos6

Ubuntu 14.04 using apache needs the web configuration to be modified to
enable the OMERO web server to run, see below.

Installing development branches
-------------------------------

By default the installation uses the latest OMERO server release. To use
a specific development build set,

    OMEROVER=omerodev

in the relevant `install-` script and in `setup_omerodev.sh` set `BRANCH`
to the required branch. By default this tracks latest,

    BRANCH=OMERO-DEV-latest

but could, for instance, be set to track the merge branch,

    BRANCH=OMERO-DEV-merge

Ubuntu 14.04/apache testing
===========================

To enable the OMERO web server, once the Docker image is running modify
the web configuration `/etc/apache2/sites-available/omero-web.conf` to
switch `WSGISocketPrefix` from its current value to,

    WSGISocketPrefix /var/run/wsgi

Then restart the apache service,

    service apache2 restart
