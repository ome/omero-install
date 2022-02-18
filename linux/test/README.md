Installation walkthroughs
=========================

This directory contains Dockerfiles for testing the installation walkthroughs.

For example:

    ./docker-build.sh ubuntu1804
    docker run --rm -it -p 8080:80 -p 4063:4063 -p 4064:4064 omero_install_test_ubuntu1804

    ./docker-build.sh debian10
    docker run --rm -it -p 8080:80 -p 4063:4063 -p 4064:4064 omero_install_test_debian10

See `docker run --help` for more information on these and other options
for running docker images.

CentOS 7 testing workflow is fully automated, for more details see below.


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

    OS=centos7 ALL=false bash autogenerate.sh

Only the "recommended" requirements will be copied to the walkthrough file.
When a requirement is modified e.g. Postgres 12 instead of Postgres 11
the following markers `#start-recommended`, `#end-recommended` should be updated
in the corresponding steps files.
The default value for given parameter should be the recommended version
e.g. openjdk18 for Java.

Nginx installation steps are added to the walkthrough file

To generate all the walkthroughs, run the following command
    
    bash autogenerate.sh

To generate a specific walkthrough, run the following command

    OS=debian10 ALL=false bash autogenerate.sh

The possible values are:
centos7 (default), ubuntu1804, ubuntu2004, debian10

Configuring Java
----------------

By default, openjdk11 is installed.
It is possible to install other versions using the JAVAVER parameter.

For example, to install openjdk11:

JAVAVER=openjdk1.8 ./docker-build.sh ubuntu1804

The supported values are: 
openjdk1.8, openjdk1.8-devel, openjdk11 (default), openjdk11-devel

If you do not want to install Java set JAVAVER to nojava.

To add a new Java version, update the following files: 
`step01_centos_java_deps.sh`, `step01_ubuntu_java_deps.sh`,
`step01_ubuntu1804_java_deps.sh`, `step01_debian10_java_deps.sh`
and update this README.md.

Configuring Postgres
--------------------

By default, Postgres 11.0 is installed.
It is possible to install other versions using the PGVER parameter.

For example:
    
    PGVER=pg10 ./docker-build.sh ubuntu1804
    
It is not necessary to specify the version when running Ubuntu/Debian image.

For example:

    docker run --rm -it -p 8080:80 -p 4063:4063 -p 4064:4064 omero_install_test_ubuntu1804


The supported values are: 
pg96, pg10, pg11 (default), pg12 (ubuntu 20.04 only)

If you do not want to install Postgres set PGVER to nopg.

To add a new Postgres version, update the following files: 
`step01_centos7_pg_deps.sh`,
`step01_ubuntu1804_pg_deps.sh`, `step01_ubuntu2004_pg_deps.sh`,
`step01_debian10_pg_deps.sh` and update this README.md.

Configuring Ice
---------------

By default, Ice 3.6 is installed.
It is possible to install other versions using the ICEVER parameter.

For example:

    ICEVER=ice36-devel ./docker-build.sh centos7

The supported values are: 
ice36-devel (CentOS 7 only), ice36

To add a new Ice version, update the following files:
`step01_centos7_ice_venv_deps.sh`, `step01_ubuntu_ice_venv_deps.sh`,
step01_ubuntu1804_ice_venv_deps.sh`, `step01_ubuntu2004_ice_venv_deps.sh`
`step01_debian10_ice_venv_deps.sh`
and update this README.md.


Testing CentOS 7
================

1. Create a test image containing the installation scripts

        $ cd linux/test
        $ export ENV=centos7
        $ ./docker-build.sh $ENV

     Notet that it is possible to use the various parameters when running the installation script e.g.

        $PGVER=pg96 ./docker-build.sh $ENV

2. Run the tests

        OSX: $ DMNAME=dev ./test_services.sh # docker machine can be obtained from docker-machine ls
        UNIX: $ ./test_services.sh

    or can be tested manually

        OSX: $ docker run -d --privileged -p 8888:80 --name omeroinstall omero_install_test_$ENV
        UNIX: $ docker run -d --name omeroinstall -v /sys/fs/cgroup:/sys/fs/cgroup:ro -v /run omero_install_test_$ENV
        wait 10 sec
        $ docker exec -it omeroinstall /bin/bash -c "service omero-server status -l --no-pager"
        Redirecting to /bin/systemctl status  -l omero-server.service
        ● omero-server.service - OMERO.server
           Loaded: loaded (/etc/systemd/system/omero-server.service; enabled; vendor preset: disabled)
           Active: active (running) since Mon 2016-04-11 13:43:23 UTC; 30s ago
         Main PID: 91 (python)
        ...
