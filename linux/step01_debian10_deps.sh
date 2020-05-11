#!/bin/bash

apt-get -y install\
    python3 \
    python3-venv

# Fix openssl issues
sed -e '/MinProtocol/ s/^#*/#/' -i /etc/ssl/openssl.cnf
sed -e '/CipherString/ s/^#*/#/' -i /etc/ssl/openssl.cnf
