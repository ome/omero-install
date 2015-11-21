OMERO installation via Homebrew
===============================

This directory contains scripts for installing OMERO on clean Mac OS X system:

- [cleanup](cleanup) completely removes all content under `/usr/local` and
is meant to be used by Continuous Integration jobs.

- [install_homebrew](install_homebrew) installs Homebrew on a fresh system,
including Homebrew Python and adds the taps required for OME formula
installation.

- [install_omero](install_omero) install the latest {major}.{minor}
version of Bio-Formats and OMERO. Additionally, it starts and test the
installed OMERO.server and OMERO.web client.
