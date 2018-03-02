#!/bin/bash

#!/bin/bash

yum -y install redis python-redis

service redis start

set +u
source /home/omero/omeroenv/bin/activate
set -u

pip install "django-redis>=4.4,<4.9"

deactivate