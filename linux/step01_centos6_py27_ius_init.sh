#!/bin/bash

# epel-release will be pulled as a dependency
yum -y install https://centos6.iuscommunity.org/ius-release.rpm

# installed for convenience
yum -y install unzip wget tar bc git