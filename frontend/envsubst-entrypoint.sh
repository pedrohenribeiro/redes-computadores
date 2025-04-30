#!/bin/sh
# insere o script de console.log / window.SERVER_NAME
# **sem alterar** as linhas originais de <script src=…> e <link href=…>
awk '
  /<head>/ {
    print
    print "  <script>console.log(\"Servidor:\", \"" ENVIRON["SERVER_NAME"] "\"); window.SERVER_NAME = \"" ENVIRON["SERVER_NAME"] "\";</script>"
    next
  }
  { print }
' /usr/share/nginx/html/index.template.html \
  > /usr/share/nginx/html/index.html

exec "$@"
