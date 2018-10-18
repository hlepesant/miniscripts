#!/bin/bash

export DEBIAN_FRONTEND=noninteractive

sed -i 's/main/main contrib non-free/' /etc/apt/sources.list

apt-get update
apt-get -qq -y dist-upgrade
apt-get -qq -y install curl vim net-tools
apt-get -qq -y install libapache2-mod-php7.0 \
	php7.0-mysql \
	php7.0 \
	php7.0-bcmath \
	php7.0-bz2 \
	php7.0-cli \
	php7.0-common \
	php7.0-curl \
	php7.0-gd \
	php7.0-interbase \
	php7.0-intl \
	php7.0-json \
	php7.0-mbstring \
	php7.0-mcrypt \
	php7.0-opcache \
	php7.0-soap \
	php7.0-xml \
	php7.0-xmlrpc \
	php7.0-xsl \
	php7.0-zip

cd /tmp
rm -f latest.tar.*
wget http://wordpress.org/latest.tar.gz

cd /var/www
rm -rf html
tar xfz /tmp/latest.tar.gz
mv wordpress html
chown -R www-data:www-data html

cat <<'EOF' >> /var/www/html/wp-config.php
<?php
define('DB_NAME', '_DB_NAME_');
define('DB_USER', '_DB_USER_');
define('DB_PASSWORD', '_DB_PASS_');
define('DB_HOST', '_DB_HOST_');
define('DB_CHARSET', 'utf8');
define('DB_COLLATE', '');
EOF

curl http://api.wordpress.org/secret-key/1.1/salt >> /var/www/html/wp-config.php

cat <<'EOF' >> /var/www/html/wp-config.php
$table_prefix  = 'wp_';
define('WP_DEBUG', false);
if ( !defined('ABSPATH') )
	define('ABSPATH', dirname(__FILE__) . '/');

require_once(ABSPATH . 'wp-settings.php');
EOF

rm -f /tmp/latest.tar.gz

service apache2 restart
