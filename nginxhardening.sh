#!/usr/bin/env bash

apt update && apt install nginx-extras -y &&

unlink /etc/nginx/sites-enabled/default

if [ ! -e "/etc/nginx/nginx.conf" ]; then
  touch /etc/nginx/nginx.conf
fi

tee "/etc/nginx/nginx.conf" > /dev/null << EOF

# /etc/nginx/nginx.conf
http {
    # Basic Settings
    server_tokens off;
    more_set_headers 'Server: Custom Header';

##buffer policy
        client_body_buffer_size 1K;
        client_header_buffer_size 1k;
        client_max_body_size 1k;
        large_client_header_buffers 2 1k;
        ##end buffer policy

location / {
limit_except GET HEAD POST { deny all; }
}

add_header X-Frame-Options "SAMEORIGIN";

add_header Content-Security-Policy "default-src 'self' http: https: data: blob: 'unsafe-inline'" always;

add_header X-XSS-Protection "1; mode=block";


EOF
