#!/bin/bash

source settings.env
# server must be running
# Add figure
cd ~omero

mkdir -p omero/figure_scripts

# install script to export images as PDF/
FOLDER=OMERO.server/lib/python/omeroweb/figure/scripts
cp $FOLDER/omero/figure_scripts/Figure_To_Pdf.py omero/figure_scripts

su - omero -c "OMERO.server/bin/omero -s localhost -u root -w $OMERO_ROOT_PASS script upload omero/figure_scripts/Figure_To_Pdf.py --official"
