#!/bin/sh
if [ ! -d "/etc/letsencrypt/live/$env_domain" ]; then
  echo "Certificate no exists for $env_domain"
  certbot certonly --standalone -d $env_domain --email $env_admin_email --agree-tos --no-eff-email
else
  nginx -s stop
  echo "Certificate already exists for $env_domain"
  certbot renew --standalone --quiet --no-self-upgrade
  nginx -g 'daemon off;'
fi
