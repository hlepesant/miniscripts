#!/bin/bash

. ./etc/hosting.conf.sh
. ./lib/website.func.sh
. ./lib/database.func.sh
. ./lib/ftpserver.func.sh


check_sudo

if [[ $# -eq 0 ]]; then
    usage_clean_website
    exit 1
fi

while getopts ":w:" opt; do
    case $opt in
        w)
            WEBSITE=${OPTARG}
            ;;
        \?)
            outputWarning "Invalid option: -$OPTARG"
            exit 1
            ;;
        :)
            missin_arg_new_website $OPTARG
            exit 1
            ;;
    esac
done


if [[ -z ${WEBSITE} ]]; then
    usage_clean_webiste
    exit 1
fi

FULLPATH=$(printf "%s/%s" ${WEB_BASE_DIR} ${WEBSITE})

check_exist_new_website ${FULLPATH}

echo $?

if [[ ${?} -eq 1 ]]; then
    outputError "${FULLPATH} do not exist !!"
    outputError "Can't continue. Bye!!"
    exit 1
fi

VHOST_FILE=$(printf "%s/vhost.conf" ${FULLPATH})

echo "WEBSITE       = ${WEBSITE}"
echo "FULLPATH      = ${FULLPATH}"
echo "LINK          = /etc/apache2/sites-enabled/${WEBSITE}.conf"
echo "VHOST_FILE    = ${VHOST_FILE}"

DOCUMENTROOT=$(get_ftp_home)
echo "DOCUMENTROOT  = ${DOCUMENTROOT}"


# MySQL
if [[ -f "${FULLPATH}/drop_user.sql" ]]; then
    drop_user
fi

if [[ -f "${FULLPATH}/drop_database.sql" ]]; then
    drop_database
fi


# PureFTP
ftp_drop_user

# Apache
if [[ -h "/etc/apache2/sites-enabled/${WEBSITE}.conf" ]]; then
    remove_virtualhost
fi

if [[ -d ${FULLPATH} ]]; then
    remove_website_folder
fi
