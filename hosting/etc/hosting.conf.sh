#!/bin/bash

WEB_BASE_DIR=/opt/WebSites

# Wordpress
WORDPRESS_URL_ARCHIVE='https://wordpress.org/latest.tar.gz'
WORDPRESS_ARCHIVE='latest.tar.gz'

# Prestashop
PRESTASHOP_URL_ARCHIVE='https://www.prestashop.com/ajax/controller.php?method=download&type=releases&language=fr&file=prestashop_1.6.1.5.zip'
PRESTASHOP_ARCHIVE='prestashop_1.6.1.5.zip'

# Magento
#MAGENTO_URL_ARCHIVE='https://codeload.github.com/OpenMage/magento-mirror/zip/magento-1.9'
MAGENTO_URL_ARCHIVE='https://codeload.github.com/OpenMage/magento-lts/zip/1.9.2.4'
MAGENTO_ARCHIVE='magento-lts-1.9.2.4.zip'



PASSWORD_MIN_LENGTH=12

APACHE_SITES_ENABLED='/etc/apache2/sites-enabled'
APACHE_USER='www-data'
APACHE_GROUP='www-data'

MYSQL_ADMIN_USER='root'
MYSQL_ADMIN_PASS='mysecretpass'
MYSQL_CLIENT_HOST='localhost'
DB_HOST='localhost'
