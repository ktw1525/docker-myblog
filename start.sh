#!/bin/sh

# 환경 변수를 치환하여 nginx.conf 파일 생성
envsubst < /etc/nginx/nginx.template > /etc/nginx/nginx.tmp

sed 's/\^/\$/g' /etc/nginx/nginx.tmp > /etc/nginx/nginx.conf

# 생성된 nginx.conf 파일 출력
echo "Generated nginx.conf:"
cat /etc/nginx/nginx.conf

/usr/local/bin/renew_certificates.sh

# Nginx를 실행
nginx -g 'daemon off;'
