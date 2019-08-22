#!/usr/bin/env bash
set -x
sudo systemctl stop nginx
unzip /tmp/files-to-deploy.zip -d /tmp


sudo rm -Rf /var/www/html 
sudo cp -R /tmp/html /var/www/

sudo cp /tmp/conf/nginx.conf /etc/nginx/conf.d/php.conf

[ -f /etc/nginx/sites-enabled/default ] && sudo unlink /etc/nginx/sites-enabled/default

sudo systemctl start nginx
rm /tmp/files-to-deploy.zip
rm /tmp/html -Rf
rm /tmp/conf -Rf