#!/bin/bash

. ./etc/hosting.conf.sh
. ./lib/website.func.sh
. ./lib/database.func.sh
. ./lib/ftpserver.func.sh


check_sudo

if [[ $# -eq 0 ]]; then
    usage_new_website
    exit 1
fi

while getopts ":w:a:u:d:f:" opt; do
    case $opt in
        a)
            APP=${OPTARG}
            ;;
        d)
            DB_NAME=${OPTARG}
            ;;
        u)
            DB_USER=${OPTARG}
            ;;
        w)
            WEBSITE=${OPTARG}
            ;;
        f)
            FTP_USER=${OPTARG}
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


if [[ -z ${WEBSITE} || -z ${FTP_USER} ]]; then
    usage_new_webiste
    exit 1
fi

check_downloader

check_uncompressor

CHECK_DB_OPTION=0
GET_APP=0

case ${APP} in
    'wordpress')
        APP_SOURCE=${WORDPRESS_URL_ARCHIVE}
        WEBDIR='wordpress'
        ARCHIVE=${WORDPRESS_ARCHIVE}
        CHECK_DB_OPTION=$((${CHECK_DB_OPTION} + 1))
        GET_APP=$((${GET_APP} + 1))
    ;;
    'prestashop')
        APP_SOURCE=${PRESTASHOP_URL_ARCHIVE}
        WEBDIR='prestashop'
        ARCHIVE=${PRESTASHOP_ARCHIVE}
        CHECK_DB_OPTION=$((${CHECK_DB_OPTION} + 1))
        GET_APP=$((${GET_APP} + 1))
    ;;
    'magento')
        APP_SOURCE=${MAGENTO_URL_ARCHIVE}
        WEBDIR='magento'
        ARCHIVE=${MAGENTO_ARCHIVE}
        CHECK_DB_OPTION=$((${CHECK_DB_OPTION} + 1))
        GET_APP=$((${GET_APP} + 1))
    ;;
    *)
        APP_SOURCE=''
        WEBDIR='web'
        APP='none'
    ;;
esac

if [[ ${CHECK_DB_OPTION} -ge 1 ]]; then
    if [[ -z ${DB_USER} ]]; then
        outputError "No MySQL user specified"
        outputError "Can't continue. Bye!!"
        exit 1
    fi

    if [[ -z ${DB_NAME} ]]; then
        outputError "No database specified"
        outputError "Can't continue. Bye!!"
        exit 1
    fi
fi

if [[ -z ${FTP_USER} ]]; then
    outputError "No FTP user specified"
    outputError "Can't continue. Bye!!"
    exit 1
fi


if [[ ${GET_APP} -ge 1 ]]; then
    outputInfo "Getting application archives : ${ARCHIVE}"
    get_web_application ${APP_SOURCE} ${ARCHIVE}
fi

FULLPATH=$(printf "%s/%s" ${WEB_BASE_DIR} ${WEBSITE})
DOCUMENT_ROOT=$(printf "%s/%s/%s" ${WEB_BASE_DIR} ${WEBSITE} ${WEBDIR})

outputInfo "Checking website do not already exist"
check_exist_new_website ${DOCUMENT_ROOT}

if [[ ${?} -eq 0 ]]; then
    outputError "${FULLPATH} already exist !!"
    outputError "Can't continue. Bye!!"
    exit 1
fi

# Apache
outputInfo "Create document root"
make_documentroot_new_website

outputInfo "Create virtualhost config file"
make_virtualhost_new_website

outputInfo "Unpacking application"
unpack_source

# MySQL
DB_PASS=$(make_password)

outputInfo "Create Database : ${DB_NAME} on ${DB_HOST}"
create_database

outputInfo "Create database user : ${DB_USER}"
create_user


case ${APP} in
    'wordpress')
        . ./lib/wordpress.func.sh
        make_wp_config
    ;;
    'prestashop')
        make_pp_config
    ;;
    'magento')
        make_mg_config
    ;;
    *)
        echo "nothing to do"
    ;;
esac

# PureFTPd
FTP_PASS=$(make_password)

outputInfo "Create FTP user : ${FTP_USER}"
ftp_create_user

# Apache 2
outputInfo "Enabling virtualhost"
enable_virtualhost

outputInfo "Reloading Apache"
restart_webserver

outputInfo " Resume"
outputInfo "--------"

outputTitle "Virtualhost"
echo "WEBSITE       = ${WEBSITE}"
echo "FULLPATH      = ${FULLPATH}"
echo "DOCUMENT_ROOT = ${DOCUMENT_ROOT}"
echo "APP           = ${APP}"
echo "APP_SOURCE    = ${APP_SOURCE}"
echo "WEBDIR        = ${WEBDIR}"

outputTitle "Database : MySQL"
echo "DB_USER       = ${DB_USER}"
echo "DB_PASS       = ${DB_PASS}"
echo "DB_NAME       = ${DB_NAME}"
echo "DB_HOST       = ${DB_HOST}"

outputTitle "FTP Access"
echo "FTP_USER       = ${FTP_USER}"
echo "FTP_PASS       = ${FTP_PASS}"
