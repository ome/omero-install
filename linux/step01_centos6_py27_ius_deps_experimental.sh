#!/bin/bash

#!/bin/bash

yum -y install redis python-redis

service redis start

set +u
source /home/omero/omeroenv/bin/activate
set -u

pip install django-redis-cache=>1.6.5

deactivate