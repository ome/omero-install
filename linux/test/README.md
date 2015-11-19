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

Centos 7 cannot be tested in this way as systemd doesn't fully work, see below.

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

Centos 7 testing
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
        bash install-centos7.sh
        #echo omero:omero | chpasswd

