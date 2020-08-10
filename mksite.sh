#! /bin/bash
# read input from user for the name of the site in order to create the root directory on /var/www/html and copy the WordPress files into the directory. Also create the vhost for the site in Apache and enable it.

echo "Please type the name for the site"
read
mkdir -p /var/www/html/$REPLY/{public_html,logs}
cp -R /var/www/html/src/wordpress/* /var/www/html/$REPLY/public_html
chown -R www-data:www-data /var/www/html/$REPLY
ls -l /var/www/html/$REPLY/public_html
