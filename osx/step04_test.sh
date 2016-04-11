
#!/usr/bin/env bash
# Start up server, perform some simple test, shutdown again.

set -e
set -u
set -x

export PATH=/usr/local/bin:$PATH
export HTTPPORT=${HTTPPORT:-8080}
export ROOT_PASSWORD=${ROOT_PASSWORD:-omero}

# Start PostgreSQL
pg_ctl -D /usr/local/var/postgres -l /usr/local/var/postgres/server.log -w start

# Start the server
omero admin start

# Start OMERO.web
omero web start
nginx -c $(brew --prefix omero52)/etc/nginx.conf

# Check OMERO version
omero version | grep -v UNKNOWN

# Test simple fake import
omero login -s localhost -u root -w $ROOT_PASSWORD
touch test.fake
omero import test.fake
omero logout

# Test simple Web connection
COOKIES=cookies.txt
LOGIN_URL=http://localhost:$HTTPPORT/webclient/login/
LOGOUT_URL=http://localhost:$HTTPPORT/webclient/logout/
SERVER='1'
CURL_CMD="curl -i -k -s -c $COOKIES -b $COOKIES "
$CURL_CMD $LOGIN_URL > /dev/null
csrf_token=$(grep csrftoken $COOKIES | sed 's/^.*csrftoken\s*//' |  sed -e 's/^[[:space:]]*//' )
DJANGO_TOKEN="csrfmiddlewaretoken=$csrf_token"

echo "Perform login ..."
RSP=$($CURL_CMD \
        -e $LOGIN_URL \
        -d "$DJANGO_TOKEN&username=root&password=$ROOT_PASSWORD&server=$SERVER" \
        -X POST $LOGIN_URL)
if grep -q id_server <<<$RSP; then
  exit 1
else
  echo "You are logged in!"
fi

echo "Perform logout ..."
$CURL_CMD \
    -e $LOGIN_URL \
    -d "$DJANGO_TOKEN" \
    -X POST $LOGOUT_URL

echo "You are logged out!"


# Stop OMERO.web
nginx -c $(brew --prefix omero52)/etc/nginx.conf -s stop
omero web stop

# Stop the server
omero admin stop

# Stop PostgreSQL
pg_ctl -D /usr/local/var/postgres -m fast stop
