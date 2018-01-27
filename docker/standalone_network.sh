#!/bin/sh
if [ -z "$2" ]; then
    echo "Usage: standalone_network.sh SUBNET_CIDR NETWORK_NAME"
    exit 1
fi

write_sysctl () {
    grep -qF "$1" /etc/sysctl.conf || echo "$1" >> /etc/sysctl.conf
}

sysctl net.ipv4.conf.all.forwarding=1
sysctl net.ipv6.conf.all.forwarding=1
write_sysctl "net.ipv4.conf.all.forwarding = 1"
write_sysctl "net.ipv6.conf.all.forwarding = 1"

docker network create --subnet $1 $2
