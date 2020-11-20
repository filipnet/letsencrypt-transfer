# letsencrypt-transfer

Transfer LetsEncrypt certificates from one Linux server to another

## FEATURES

If DNS A-records terminate at a load balancer, a LetsEncrypt certificate can only be created here with certbot or a comparable command line tool. If this is done successfully, the certificates have to find their way to the NGNIX, APACHE, POSTFIX backend server.

For this purpose, Linux board resources in the form of SSH using a certificate as well as RSYNC are suitable.

## HOW TO USE

- Download the script ```cd /root && git clone https://github.com/filipnet/letsencrypt-transfer.git```
- Use the script by its input parameters in e.g. ```/etc/crontab```
- Or create a "helper-script" to do some more actions ```vim /root/letsencrypt-transfer/transfer-certs-lb.sh```

### SAMPLE HELPER SCRIPT

```
echo "Starting LetsEncrypt certificate transfer"
# LetsEncrypt Archive
/root/letsencrypt-transfer/letsencrypt-transfer-certs.sh lb.domain.de /etc/letsencrypt/archive/lb.domain.de/ /etc/letsencrypt/archive/lb.domain.de/ /root/rsa-key/id_rsa_lb.domain.de.pem
# LetsEncrypt Live (Notice that the live-folder only use SYMLINKS)
/root/letsencrypt-transfer/letsencrypt-transfer-certs.sh lb.domain.de /etc/letsencrypt/live/lb.domain.de/ /etc/letsencrypt/live/lb.domain.de/ /root/rsa-key/id_rsa_lb.domain.de.pem

echo "Restart Apache"
apachectl graceful

echo "Restart Dovecot"
systemctl reload dovecot

echo "Restart Postfix"
systemctl reload postfix
```

## LICENSE

letsencrypt-transfer and all individual scripts are under the BSD 3-Clause license unless explicitly noted otherwise. Please refer to the LICENSE