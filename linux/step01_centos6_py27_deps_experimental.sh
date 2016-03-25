#!/bin/bash

#!/bin/bash

yum -y install redis python-redis

set +u
source /opt/rh/python27/enable
set -u

pip install django-redis-cache>=1.6.5
