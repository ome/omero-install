#!/bin/bash

ICEVER=${ICEVER:-ice36}


# Ice installation
if [ "$ICEVER" = "ice36" ]; then
    #start-recommended
    apt-get -y install zeroc-ice-all-runtime
    #end-recommended
fi