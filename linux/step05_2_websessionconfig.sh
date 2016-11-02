#!/bin/bash

PY_ENV=${PY_ENV:-py27}

cd ~omero

echo "value=$PY_ENV"
# Install required packages
if [ "$PY_ENV" = "py27_scl" ]; then
	set +u
	source /opt/rh/python27/enable
	set -u
elif [ "$PY_ENV" = "py27_ius" ]; then
	virtualenv -p /usr/bin/python2.7 /home/omero/omeroenv
	set +u
	source /home/omero/omeroenv/bin/activate
	set -u
fi

# Register the app
su - omero -c "OMERO.server/bin/omero config set omero.web.session_engine 'django.contrib.sessions.backends.cache'"
su - omero -c "OMERO.server/bin/omero config set omero.web.caches '{\"default\": {\"BACKEND\": \"django_redis.cache.RedisCache\",\"LOCATION\": \"redis://127.0.0.1:6379/0\"}}'"
