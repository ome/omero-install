#!/bin/bash

#!/bin/bash

yum -y install redis python-redis

service redis start

set +u
source /opt/rh/python27/enable
set -u

pip install django-redis>=4.4
