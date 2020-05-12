#!/bin/bash
PYTHONVER=${PYTHONVER:-default}
ICEVER=${ICEVER:-ice36}

# start-add-dependencies
apt-get update
apt-get -y install \
	unzip \
	wget
# end-add-dependencies
if [ "$PYTHONVER" = "py36" ]; then
    # start-install-Python36
    add-apt-repository ppa:deadsnakes/ppa
    apt-get update
    apt-get install -y python3.6 python3.6-venv python3.6-dev
    # dependencies required to install Ice Python binding
    apt-get install -y build-essential libssl-dev libffi-dev \
                       libbz2-dev libxml2-dev libxslt1-dev zlib1g-dev
    # end-install-Python36                   
else
    # start-default
    apt-get -y install python3 python3-venv
    # end-default
fi
