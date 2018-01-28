# letsencrypt.sh
Installs certbot and registers an account with letsencrypt.

## Usage:
```sh
curl https://raw.githubusercontent.com/corysm1th/centos7_scripts/master/letsencrypt/letsencrypt.sh | sh -s EMAIL_ADDRESS
```

Make sure the certbot server is publicly accessible over port 80, and run:
```sh
certbot certonly --standalone --prefered-challenges http -d FQDN
```
