#!/bin/ash
TOKEN="$(openssl rand -hex 16)"

sed -i -e "s/change me!/$TOKEN/" /etc/nginx/nginx.conf

# start nginx
/usr/sbin/nginx -g "daemon off;"