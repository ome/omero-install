
#!/usr/bin/env bash
# Start up server, perform some simple test, shutdown again.

set -e
set -u
set -x

export HTTPPORT=${HTTPPORT:-8080}
export ROOT_PASSWORD=${ROOT_PASSWORD:-omero}
export ICE_CONFIG=$(bin/brew --prefix omero52)/etc/ice.config
export PYTHONPATH=$(bin/brew --prefix omero52)/lib/python

cd /usr/local

# Start PostgreSQL
bin/pg_ctl -D /usr/local/var/postgres -l /usr/local/var/postgres/server.log -w start

# Start the server
bin/omero admin start

# Start OMERO.web
bin/omero web start
nginx -c $(bin/brew --prefix omero52)/etc/nginx.conf

# Check OMERO version
bin/omero version | grep -v UNKNOWN

# Test simple fake import
bin/omero login -s localhost -u root -w $ROOT_PASSWORD
touch test.fake
bin/omero import tes

# Test simple Web connection
brew install wget
sleep 30
wget --keep-session-cookies --save-cookies cookies.txt http://localhost:$HTTPPORT/webclient/login/ -O csrf_index.html
csrf=$(cat csrf_index.html | grep "name=\'csrfmiddlewaretoken\'"  | sed "s/.* value=\'\(.*\)\'.*/\1/")
post_data="username=root&password=$ROOT_PASSWORD&csrfmiddlewaretoken=$csrf&server=1&noredirect=1"
resp=$(wget --keep-session-cookies --load-cookies cookies.txt --post-data $post_data http://localhost:$HTTPPORT/webclient/login/)
echo "$resp"

# Stop OMERO.web
nginx -c $(bin/brew --prefix omero52)/etc/nginx.conf -s stop
bin/omero web stop

# Stop the server
bin/omero admin stop

# Stop PostgreSQL
bin/pg_ctl -D /usr/local/var/postgres -m fast stop
