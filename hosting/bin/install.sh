#!/bin/bash

. ./etc/hosting.conf.sh
. ./lib/output.func.sh
. ./lib/commoncheck.func.sh


check_sudo


packages=(
libapache2-mod-php5
php5-cli
php5-common
php5-curl
php5-gd
php5-json
php5-mysql
php5-readline
mysql-client-5.5
mysql-server-5.5
pwgen
pure-ftpd
)

modules=(
rewrite
expires
)

outputInfo "Refreshing DB"
${APTGET} update > /dev/null 2>&1

for p in "${packages[@]}"
do
    ${DPKG} -l ${p} > /dev/null 2>&1 
    if [[ $? -ne 0 ]]; then
        outputInfo "Installing ${p}"
        ${APTGET} install ${p}
    fi
done

# Apache

restart_apache=0

for m in "${modules[@]}"
do
    if [[ ! -h "/etc/apache2/mods-enabled/${m}.load" ]]; then
        outputInfo "Enabling Apache module ${m}"
        a2enmod ${m}
        restart_apache=$(($restart_apache + 1))
    fi
done

if [[ ${restart_apache} -ge 1 ]]; then
    outputInfo "Restarting Apache"
    service apache2 restart
fi


# MySQL 

# PureFTPd
if [[ ! -h "/etc/pure-ftpd/auth/50pure" ]]; then
    ${LS} -s /etc/pure-ftpd/conf/PureDB /etc/pure-ftpd/auth/50pure
fi
echo "yes" > /etc/pure-ftpd/conf/ChrootEveryone
echo "33" > /etc/pure-ftpd/conf/MinUID
echo "no" > /etc/pure-ftpd/conf/PAMAuthentication
