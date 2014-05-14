#!/bin/bash

# See setup_omero.sh for the nginx config file creation

if [ -d /etc/nginx/sites-available/ -a -d /etc/nginx/sites-enabled/ ]; then
    # Debian
    NGINX_CONF=/etc/nginx/sites-available/omero-web
    cp OMERO.server/nginx.conf.tmp ${NGINX_CONF}
    rm /etc/nginx/sites-enabled/default
    ln -s ${NGINX_CONF} /etc/nginx/sites-enabled/
elif [ -d /etc/nginx/conf.d/ ]; then
    # Redhat
    NGINX_CONF=/etc/nginx/conf.d/omero-web.conf
    mv /etc/nginx/conf.d/default.conf /etc/nginx/conf.d/default.disabled
    cp OMERO.server/nginx.conf.tmp ${NGINX_CONF}
else
    echo "ERROR: Unable to find nginx configuration directory"
    exit 2
fi

service nginx start

