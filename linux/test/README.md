Installation walkthroughs
=========================

This directory contains Dockerfiles for testing the installation walkthroughs.

For example:

    ./docker-build.sh ubuntu1404_nginx
    docker run --rm -it -p 8080:80 -p 4063:4063 -p 4064:4064 omero_install_test_ubuntu1404_nginx

    ./docker-build.sh centos6_apache22
    docker run --rm -it -p 8080:80 -p 4063:4063 -p 4064:4064 omero_install_test_centos6_apache22

    ./docker-build.sh centos6_py27_ius_nginx
    docker run --rm -it -p 8080:80 -p 4063:4063 -p 4064:4064 omero_install_test_centos6_py27_ius_nginx

See `docker run --help` for more information on these and other options
for running docker images.

CentOS 7 cannot be tested in this way as `systemd` doesn't fully work, see below.

Configuring Java
----------------

By default, openjdk1.8 is installed.
It is possible to install other versions using the JAVAVER parameter

For example, to install oracle-java:

JAVAVER=oracle18 ./docker-build.sh ubuntu1404_nginx

The supported values are: 
openjdk17, openjdk18, openjdk17-devel, openjdk18-devel, oracle17, oracle18

If you do not want to install Java set JAVAVER to nojava

Configuring Postgres
--------------------

By default, Postgres 9.4 is installed.
It is possible to install other versions using the PGVER parameter

For example:

    PGVER=pg95 ./docker-build.sh centos6_py27_ius_nginx
    docker run --rm -it -p 8080:80 -p 4063:4063 -p 4064:4064 omero_install_test_centos6_py27_ius_nginx pg95

    PGVER=pg95 ./docker-build.sh ubuntu1404_nginx
    docker run --rm -it -p 8080:80 -p 4063:4063 -p 4064:4064 omero_install_test_ubuntu1404_nginx

Note that you do not need to specify the version when running the Ubuntu/Debian image.
The supported values are: 
pg94, pg95

If you do not want to install Postgres set PGVER to nopg

Configuring Ice
---------------

By default, Ice 3.5 is installed.
It is possible to install other versions using the ICEVER parameter

For example:

    ICEVER=ice35-devel ./docker-build.sh ubuntu1404_nginx

The supported values are: 
ice35, ice35-devel

Installing web applications
---------------------------

By default the installation walkthroughs do not install any of the web applications.
To create a test image with: figure (https://github.com/ome/figure), 
gallery (https://github.com/ome/gallery), webtest (https://github.com/openmicroscopy/webtest) and
webtagging (https://github.com/MicronOxford/webtagging), you can pass `WEBAPPS=true` to the build
script.

For example:

    WEBAPPS=true ./docker-build.sh ubuntu1404_nginx
    docker run --rm -it -p 8080:80 -p 4063:4063 -p 4064:4064 omero_install_test_ubuntu1404_nginx


Installing development branches
-------------------------------

By default the installation uses the latest OMERO server release. To use
a specific development, you can specify as a parameter one of the development versions
when building the image.

For example:

    OMEROVER=OMERO-DEV-latest ./docker-build.sh ubuntu1404_nginx

The supported values are: 
OMERO-DEV-latest, OMERO-DEV-merge-build, latest

CentOS 7 testing
================

1. Create a test image containing the installation scripts
2. Start the container (this requires special options for systemd which may depend on your host system, see the [parent README](https://github.com/ome/ome-docker/blob/master/omero-ssh-systemd/README.md))
3. ssh in
4. Change into the `/omero-install-test` directory
5. Run the scripts
6. Optionally set a system password for the `omero` user if you want to allow ssh access

        ./docker-build.sh centos7
        CID=$(docker run -d ... -v /sys/fs/cgroup:/sys/fs/cgroup:ro omero_install_test_centos7)
        #CID=$(docker run -d ... --privileged omero_install_test_centos7)
        ssh -o UserKnownHostsFile=/dev/null root@<address of container> # Password: omero
        cd /omero-install-test
        bash install_centos7_nginx.sh
        #echo omero:omero | chpasswd
