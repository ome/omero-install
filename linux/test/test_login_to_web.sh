#!/bin/bash
#

set -u
set -e
set -x

WEB_HOST=${WEB_HOST:-127.0.0.1:80}

COOKIES=cookies.txt

LOGIN_URL=http://$WEB_HOST/webclient/login/
LOGOUT_URL=http://$WEB_HOST/webclient/logout/

source ../settings.env

OMERO_ROOT='root'
SERVER='1'
CURL_CMD="curl -i -k -s -c $COOKIES -b $COOKIES "

$CURL_CMD $LOGIN_URL > /dev/null

csrf_token=$(grep csrftoken $COOKIES | sed 's/^.*csrftoken\s*//' |  sed -e 's/^[[:space:]]*//' )

DJANGO_TOKEN="csrfmiddlewaretoken=$csrf_token"

echo "Perform login ..."
RSP=$($CURL_CMD \
        -e $LOGIN_URL \
        -d "$DJANGO_TOKEN&username=$OMERO_ROOT&password=$OMERO_ROOT_PASS&server=$SERVER" \
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
