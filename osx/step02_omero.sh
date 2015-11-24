#!/usr/bin/env bash
# Main OMERO installation script

set -e
set -u
set -x

export OMERO_DATA_DIR=${OMERO_DATA_DIR:-/tmp/var/OMERO.data}
export PSQL_SCRIPT_NAME=PSQL_SCRIPT_NAME:-OMERO.sql}
export ROOT_PASSWORD=${ROOT_PASSWORD:-omero}
export ICE=${ICE:-3.5}
export HTTPPORT=${HTTPPORT:-8080}

cd /usr/local

###################################################################
# OMERO installation
###################################################################

# Install PostgreSQL and OMERO
OMERO_PYTHONPATH=$(bin/brew --prefix omero52)/lib/python
bin/brew install omero52 --with-nginx --with-cpp
export PYTHONPATH=$OMERO_PYTHONPATH
VERBOSE=1 bin/brew test omero52

# Install OMERO Python dependencies
bin/pip install -r $(bin/brew --prefix omero52)/share/web/requirements-py27-nginx.txt
bash bin/omero_python_deps

# Set additional environment variables
export ICE_CONFIG=$(bin/brew --prefix omero52)/etc/ice.config

# Install PostgreSQL
bin/brew install postgres

# Start PostgreSQL
bin/pg_ctl -D $PSQL_DIR -l $PSQL_DIR/server.log -w start

# Create user and database
bin/createuser -w -D -R -S db_user
bin/createdb -E UTF8 -O db_user omero_database
bin/psql -h localhost -U db_user -l

# Set database
bin/omero config set omero.db.name omero_database
bin/omero config set omero.db.user db_user
bin/omero config set omero.db.pass db_password

# Run DB script
bin/omero db script --password $ROOT_PASSWORD -f $PSQL_SCRIPT_NAME
bin/psql -h localhost -U db_user omero_database < $PSQL_SCRIPT_NAME
rm $PSQL_SCRIPT_NAME

# Set up the data directory
if [ -d "$OMERO_DATA_DIR" ]; then
    rm -rf $OMERO_DATA_DIR
fi
mkdir -p $OMERO_DATA_DIR
bin/omero config set omero.data.dir $OMERO_DATA_DIR

# Start the server
bin/omero admin start

# Check OMERO version
bin/omero version | grep -v UNKNOWN

# Test simple fake import
bin/omero login -s localhost -u root -w $ROOT_PASSWORD
touch test.fake
bin/omero import test.fake
bin/omero logout

# Start OMERO.web
bin/omero web config nginx-development --http $HTTPPORT > $(bin/brew --prefix omero52)/etc/nginx.conf
bin/omero web start
nginx -c $(bin/brew --prefix omero52)/etc/nginx.conf

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
bin/pg_ctl -D $PSQL_DIR  -m fast stop
