#!/bin/sh

# fallback se a variável não estiver definida
export SERVER_NAME="${SERVER_NAME:-Servidor Desconhecido}"

# substitui ${SERVER_NAME} no HTML
envsubst '$SERVER_NAME' \
  < /usr/share/nginx/html/index.html \
  > /usr/share/nginx/html/index.html.tmp

mv /usr/share/nginx/html/index.html.tmp /usr/share/nginx/html/index.html

exec nginx -g 'daemon off;'
