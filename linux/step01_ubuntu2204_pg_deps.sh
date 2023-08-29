#!/bin/bash

#start-recommended
apt-get update
apt-get -y install postgresql
service postgresql start
#end-recommended
