#!/bin/sh
if [ -z "$1"]; then
    echo "Usage: standalone_network.sh SUBNET_CIDR"
    exit 1
fi

sysctl net.ipv4.conf.all.forwarding=1
sysctl net.ipv6.conf.all.forwarding=1
echo "net.ipv4.conf.all.forwarding = 1" >> /etc/sysctl.conf
echo "net.ipv6.conf.all.forwarding = 1" >> /etc/sysctl.conf

docker network create --subnet $1 docker1
