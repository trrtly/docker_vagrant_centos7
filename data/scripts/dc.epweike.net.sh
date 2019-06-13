#!/usr/bin/env bash

proj="dc.epwk.com"
dest="/data/webroot/${proj}"
git clone http://git.epweike.net:3000/epwk/${proj}.git ${dest} \
&& cd ${dest} \
&& git checkout -b develop origin/dev \
&& cp .env.example .env \
&& rm -rf bin/composer bin/phpunit \
&& composer install --ignore-platform-reqs \
&& cp /data/nginx/vhost/${proj}.conf.example /data/nginx/vhost/${proj}.conf \
&& cd /data \
&& docker-compose restart \
&& echo "${proj} 本地部署成功"
