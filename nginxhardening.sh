#!/usr/bin/env bash

if [ ! -e "/etc/nginx/nginx.conf" ]; then
  touch /etc/nginx/nginx.conf
fi

tee "/etc/nginx/nginx.conf" > /dev/null << EOF
client_body_buffer_size 1k

location / {
limit_except GET HEAD POST { deny all; }
}

add_header X-Frame-Options "SAMEORIGIN";

add_header Content-Security-Policy "default-src 'self' http: https: data: blob: 'unsafe-inline'" always;

add_header X-XSS-Protection "1; mode=block";


EOF
