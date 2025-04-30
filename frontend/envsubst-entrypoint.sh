#!/bin/sh
envsubst '$SERVER_NAME' \
  < /usr/share/nginx/html/index.template.html \
  > /usr/share/nginx/html/index.html

exec "$@"
