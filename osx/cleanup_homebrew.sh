#!/usr/bin/env bash
# Cleanup script for CI testing

set -e
set -u
set -x

# Stop existing instance of OMERO
pkill icegridnode || echo No OMERO.server running
pkill python || echo No OMERO.Web running
pkill nginx || echo No nginx running
pkill postgres || echo No PostgreSQL running

# Clean existing Homebrew
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/uninstall)"
