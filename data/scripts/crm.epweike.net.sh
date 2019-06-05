#!/usr/bin/env bash

proj="crm.epweike.net"
dest="/data/webroot/${proj}"
git clone http://git.epweike.net:3000/epwk/${proj}.git ${dest} \
&& cd ${dest} \
&& git checkout -b develop origin/develop \
&& cp .env.example .env \
&& composer install --ignore-platform-reqs \
&& cp /data/nginx/vhost/${proj}.conf.example /data/nginx/vhost/${proj}.conf \
&& cd /data \
&& docker-compose restart nginx \
&& echo "${proj} 本地部署成功"
