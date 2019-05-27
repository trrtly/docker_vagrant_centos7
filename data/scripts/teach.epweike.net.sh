#!/usr/bin/env bash

proj="teach.epweike.net"
dest="/data/webroot/${proj}"
git clone http://git.epweike.net:3000/suyaqi/${proj}.git ${dest} \
&& cd ${dest} \
&& git checkout -b develop origin/develop \
&& composer install --ignore-platform-reqs \
&& cp /data/nginx/vhost/${proj}.conf.example /data/nginx/vhost/${proj}.conf \
&& cd /data \
&& docker-compose restart nginx \
&& echo "${proj} 本地部署成功"
