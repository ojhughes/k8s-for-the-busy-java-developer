certbot certonly \
  --dns-google \
  --dns-google-credentials certbot-dns.key.json \
  -d ui.kubedemo.xyz \
  --logs-dir=/tmp/certbot --work-dir=/tmp/certbot --config-dir=/tmp/certbot --debug
