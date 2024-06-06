# Base image
FROM nginx:latest

# Install Certbot and cron
RUN apt-get update && \
    apt-get install -y certbot python3-certbot-nginx cron && \
    apt-get clean

# Copy Nginx configuration file
COPY nginx.conf /etc/nginx/nginx.template

# Copy script for renewing certificates
COPY renew_certificates.sh /usr/local/bin/renew_certificates.sh
RUN chmod +x /usr/local/bin/renew_certificates.sh

# Create crontab file for root
RUN echo "" > /etc/crontab \
    && echo "0 0 * * * /usr/local/bin/renew_certificates.sh >> /var/log/cron.log 2>&1" >> /etc/crontab

# Copy crontab file and set permissions
RUN crontab /etc/crontab

# 시작 스크립트 복사
COPY start.sh /start.sh

# 시작 스크립트 실행 권한 부여
RUN chmod +x /start.sh

# Nginx 포트 노출
EXPOSE 80

ENTRYPOINT ["/start.sh"]