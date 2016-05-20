#!/bin/bash

. ./lib/output.func.sh
. ./lib/security.func.sh


function usage_new_website() {
    outputTitle " Usage :"
    outputTitle "---------"
    outputNotice "${0} -w www.newsite.tld"
    echo ""
}

function missin_arg_new_website() {
    outputTitle " Error :"
    outputTitle "---------"
    outputWarning "Option -${1} requires an argument." >&2
    echo ""
}

function check_exist_new_website() {

    local fullpath=${1}

    if [[ -d ${fullpath} ]]; then
        return 0
    fi
    return 1
}

function make_documentroot_new_website() {

    mkdir -p ${FULLPATH}
}

function make_virtualhost_new_website() 
{
cat << EOF >  ${WEB_BASE_DIR}/${WEBSITE}/vhost.conf
<VirtualHost *:80>
	ServerName ${WEBSITE}
	ServerAdmin webmaster@localhost
	DocumentRoot ${FULLPATH}

	<Directory ${FULLPATH}>
		Require all granted
		AllowOverride All
		Options -Indexes
	</Directory>

	ErrorLog \${APACHE_LOG_DIR}/${WEBSITE}_error.log
	CustomLog \${APACHE_LOG_DIR}/${WEBSITE}_access.log combined

</VirtualHost>
EOF
}
