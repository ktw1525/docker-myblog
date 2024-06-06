#!/bin/bash
sudo docker build -t nginx-certbot .
sudo docker-compose up -d
