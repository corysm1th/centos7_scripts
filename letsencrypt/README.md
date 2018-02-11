# letsencrypt.sh
Installs certbot and registers an account with letsencrypt.

## Install certbot:
```sh
curl https://raw.githubusercontent.com/corysm1th/centos7_scripts/master/letsencrypt/letsencrypt.sh | sh \
    -s EMAIL_ADDRESS
```

## Request a certificate
- Make sure the certbot server is publicly accessible over port 80
- Make sure the certificate's CN has a DNS record pointing the host running certbot

Run:
```sh
certbot certonly --standalone --preferred-challenges http -d FQDN
```
