# gitlab_container_install.sh
This script installs GitLab Community Edition inside a docker container, on a standalone docker host.

## Assumptions
- Docker is already installed on the host
- Docker host has a routeable network, and containers can be assigned an IP address.  I favored this decision over docker0 port mappings because of how commonly 80, 443, and most importantly 22 are already used by the host or other containers.
- SSL certificates have been copied to `/data/gitlab/ssl/`

### SSL Certificates
GitLab will look for your certificates at `/data/gitlab/ssl/`, with the names `FQDN.crt` and `FQDN.key`, where `FQDN` is the fully qualified domain name of the GitLab host.

**Example:**
```
GitLab URL: https://git.yourdomain.com
GitLab FQDN: git.yourdomain.com
Certificate Name: /data/gitlab/ssl/git.yourdomain.com.crt
Private Key: /data/gitlab/ssl/git.yourdomain.com.key
```
Note for clarity: Paths are on the Docker host, and volumed in to the container.

## Usage
```
curl https://raw.githubusercontent.com/corysm1th/centos7_scripts/master/gitlab/gitlab_container_install.sh | sh \
    -s DOCKER_NETWORK IP_ADDRESS FQDN
```
