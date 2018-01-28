#!/bin/sh
if [ -z "$3" ]; then
    echo "Usage: gitlab_container_install.sh DOCKER_NETWORK IP_ADDRESS FQDN"
    exit 1
fi

if [ ! -f /data/gitlab/ssl/$3.crt ]; then
    echo "Missing /data/gitlab/ssl/$3.crt"
    mkdir -p /data/gitlab/ssl
    touch /data/gitlab/ssl/$3.crt
    exit 1
fi

if [ ! -f /data/gitlab/ssl/$3.key ]; then
    echo "Missing /data/gitlab/ssl/$3.key"
    touch /data/gitlab/ssl/$3.key
    exit 1
fi

iptables -I INPUT -p tcp -m state --state NEW -m tcp --dport 443 -j ACCEPT
iptables -I FORWARD -d $2 -j ACCEPT
iptables-save | awk '!COMMIT||!x[$0]++' | iptables-restore

mkdir -p /data/gitlab/{config,logs,data}

docker run -d --net $1 --ip $2 \
    --name $3 \
    --env GITLAB_OMNIBUS_CONFIG="external_url 'https://\${3}/';" \
    --name gitlab \
    --restart always \
    --volume /data/gitlab/config:/etc/gitlab:Z \
    --volume /data/gitlab/logs:/var/log/gitlab:Z \
    --volume /data/gitlab/data:/var/opt/gitlab:Z \
    --volume /data/gitlab/ssl:/etc/gitlab/ssl:Z \
    gitlab/gitlab-ce:latest
