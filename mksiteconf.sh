#! /bin/bash
# Read input form the user and create the vhost configuration files for the site.
echo "Please type the name of the site whitout the extention .com"
read
cat > /etc/apache2/sites-available/$REPLY.com.conf <<EOF
<VirtualHost *:80>
    # The primary domain for this host
    ServerName $REPLY.com
    # Optionally have other subdomains also managed by this Virtual Host
    ServerAlias $REPLY.com *.$REPLY.com
    DocumentRoot /var/www/html/$REPLY.com/public_html
    ErrorLog /var/www/html/$REPLY.com/logs/error.log
    CustomLog /var/www/html/$REPLY.com/logs/access.log combined
    <Directory /var/www/html/$REPLY.com/public_html>
        Require all granted
        # Allow local .htaccess to override Apache configuration settings
        AllowOverride all
    </Directory>
    # Enable RewriteEngine
    RewriteEngine on
    RewriteOptions inherit

    # Block .svn, .git
    RewriteRule \.(svn|git)(/)?$ - [F]

    # Catchall redirect to www.$REPLY.com
    RewriteCond %{HTTP_HOST}   !^www.$REPLY\.com [NC]
    RewriteCond %{HTTP_HOST}   !^$
    RewriteRule ^/(.*)         https://www.$REPLY.com/$1 [L,R]

    # Recommended: XSS protection
    <IfModule mod_headers.c>
        Header set X-XSS-Protection "1; mode=block"
        Header always append X-Frame-Options SAMEORIGIN
    </IfModule>
</VirtualHost>
EOF
