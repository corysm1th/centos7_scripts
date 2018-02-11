#!/bin/sh
if [ -z "$1" ]; then
    echo "Usage: letsencrypt.sh EMAIL_ADDRESS"
    exit 1
fi

yum install -y epel-release
yum install -y certbot
certbot register --non-interactive --agree-tos -m $1
