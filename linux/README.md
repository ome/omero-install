Example OMERO Linux install scripts
===================================

This directory contains examples of installing OMERO on clean Ubuntu 14.04,
Debian 8, CentOS 6 and Centos7 64-bit systems, see
http://www.openmicroscopy.org/site/support/omero5/sysadmins/unix/server-linux-walkthrough.html

Copy the files from this directory, then run one of the install scripts,

	bash centos6_apache22
	bash centos6_nginx
	bash centos6_py27_apache24
	bash centos6_py27_nginx
	bash debian8_nginx
	bash ubuntu1404_apache24
	bash ubuntu1404_nginx

corresponding to the required OS and web platform. Note that for Centos 6
there are separate scripts for Python 2.7, the default is Python 2.6.

Usernames and passwords can be customized in `settings.env`.

