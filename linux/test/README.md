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

CentOS 7 testing workflow is fully automated, for more details see below


Adding a new step
-----------------

When adding a new step e.g. ice support:
1. first create either a file per OS or for a group of OS.
2. update the install_* scripts.
3. if a new parameter has to be introduce, the various Dockerfile and docker-build.sh in the 
test directory have to be updated.
4. add a new configuration section to this README.md.

Generating the walkthrough for documentation
--------------------------------------------

The walkthrough files should be used for documentation purpose.
To generate the walkthrough file corresponding to a given OS i.e. `walkthough_OS.sh`,
run for example:

    OS=centos6 bash autogenerate.sh

Only the "recommended" requirements will be copied to the walkthrough file.
When a requirement is modified e.g. Postgres 9.5 instead of Postgres 9.4
the following markers `#start-recommended`, `#end-recommended` should be updated
in the corresponding steps files.
The default value for given parameter should be the recommended version
e.g. openjdk18 for Java.

Both nginx and apache installation steps are added to the walkthrough file

The possible values are:
centos7 (default), centos6, centos6_py27, centos6_py27_ius, debian8, ubuntu1404

Configuring Java
----------------

By default, openjdk1.8 is installed.
It is possible to install other versions using the JAVAVER parameter

For example, to install oracle-java:

JAVAVER=oracle18 ./docker-build.sh ubuntu1404_nginx

The supported values are: 
openjdk17, openjdk18 (default), openjdk17-devel, openjdk18-devel, oracle17, oracle18

If you do not want to install Java set JAVAVER to nojava.

To add a new Java version, update the following files 
`step01_centos_java_deps.sh`, `step01_debian8_java_deps.sh`,
`step01_ubuntu1404_java_deps.sh` and update this README.md.

Configuring Postgres
--------------------

By default, Postgres 9.4 is installed.
It is possible to install other versions using the PGVER parameter

For example:

    PGVER=pg95 ./docker-build.sh centos6_py27_ius_nginx
    
    PGVER=pg95 ./docker-build.sh ubuntu1404_nginx
    
To run the image for centOS 6  image, you need to pass the version used e.g. pg95 if the version 
is not the default one. It is not necessary to specify the version when running ubuntu/Debian image.

For example:

    docker run --rm -it -p 8080:80 -p 4063:4063 -p 4064:4064 omero_install_test_centos6_py27_ius_nginx pg95

    docker run --rm -it -p 8080:80 -p 4063:4063 -p 4064:4064 omero_install_test_ubuntu1404_nginx


The supported values are: 
pg94 (default), pg95

If you do not want to install Postgres set PGVER to nopg.

To add a new Postgres version, update the following files 
`step01_centos6_pg_deps.sh`, `step01_centos7_pg_deps.sh`, `step01_debian8_pg_deps.sh`,
`step01_ubuntu1404_pg_deps.sh` and update this README.md.

Configuring Ice
---------------

By default, Ice 3.5 is installed.
It is possible to install other versions using the ICEVER parameter

For example:

    ICEVER=ice35-devel ./docker-build.sh ubuntu1404_nginx

The supported values are: 
ice35, ice35-devel, ice36

To add a new Ice version, update the following files 
`step01_centos6_ice_deps.sh`, `step01_centos6_py27_ice_deps.sh`, `step01_centos6_py27_ius_ice_deps.sh`
`step01_centos7_ice_deps.sh`, `step01_ubuntu1404_ice_deps.sh` and update this README.md.

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
OMERO-DEV-latest, OMERO-DEV-merge-build, latest (default)

Testing CentOS 7
================

1. Create a test image containing the installation scripts

        $ cd linux/test
        NGINX $ export ENV=centos7_nginx
        APACHE $ export ENV=centos7_apache24
        $ ./docker-build.sh $ENV

     Notet that it is possible to use the various parameters when running the installation script e.g.

        $PGVER=pg95 ./docker-build.sh $ENV

2. Run tests

        OSX: $ DMNAME=dev ./test_services.sh # docker machine can be obtained from docker-machine ls
        UNIX: $ ./test_services.sh

    or can be tested manually

        OSX: $ docker run -d --privileged -p 8888:80 --name omeroinstall omero_install_test_$ENV
        UNIX: $ docker run -d --name omeroinstall -v /sys/fs/cgroup:/sys/fs/cgroup:ro -v /run omero_install_test_$ENV
        wait 10 sec
        $ docker exec -it omeroinstall /bin/bash -c "service omero status"
        Redirecting to /bin/systemctl status  -l omero.service
        ● omero.service - OMERO.server
           Loaded: loaded (/etc/systemd/system/omero.service; enabled; vendor preset: disabled)
           Active: active (running) since Mon 2016-04-11 13:43:23 UTC; 30s ago
         Main PID: 91 (python)
        ...
        $ docker exec -it omeroinstall /bin/bash -c "service omero-web status"
        Redirecting to /bin/systemctl status  -l omero-web.service
        ● omero-web.service - OMERO.web
           Loaded: loaded (/etc/systemd/system/omero-web.service; enabled; vendor preset: disabled)
           Active: active (running) since Mon 2016-04-11 13:43:27 UTC; 26s ago
          Process: 69 ExecStart=/home/omero/OMERO.server/bin/omero web start (code=exited, status=0/SUCCESS)
         Main PID: 493 (gunicorn)
        ...
