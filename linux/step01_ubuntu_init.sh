#!/bin/bash

apt-get update

# installed for convenience
apt-get -y install unzip wget bc

# to be installed if recommended/suggested is false
apt-get -y install cron
