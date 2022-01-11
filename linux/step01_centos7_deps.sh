#!/bin/bash

yum -y install centos-release-scl
yum install -y --setopt=tsflags=nodocs rh-python38-python

yum -y install openssl
