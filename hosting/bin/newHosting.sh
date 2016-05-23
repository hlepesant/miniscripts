#!/bin/bash

. ./etc/hosting.conf.sh
. ./lib/website.func.sh
. ./lib/database.func.sh


check_sudo

if [[ $# -eq 0 ]]; then
    usage_new_website
    exit 1
fi

while getopts ":w:a:u:d:" opt; do
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

if [[ ${GET_APP} -ge 1 ]]; then
    get_web_application ${APP_SOURCE} ${ARCHIVE}
fi

FULLPATH=$(printf "%s/%s" ${WEB_BASE_DIR} ${WEBSITE})
DOCUMENT_ROOT=$(printf "%s/%s/%s" ${WEB_BASE_DIR} ${WEBSITE} ${WEBDIR})

check_exist_new_website ${DOCUMENT_ROOT}

if [[ ${?} -eq 0 ]]; then
    outputError "${FULLPATH} already exist !!"
    outputError "Can't continue. Bye!!"
    exit 1
fi

echo "WEBSITE       = ${WEBSITE}"
echo "FULLPATH      = ${FULLPATH}"
echo "DOCUMENT_ROOT = ${DOCUMENT_ROOT}"
echo "APP           = ${APP}"
echo "APP_SOURCE    = ${APP_SOURCE}"
echo "WEBDIR        = ${WEBDIR}"

# Apache
make_documentroot_new_website
make_virtualhost_new_website
unpack_source

# MySQL
DB_PASS=$(make_password)

echo "DB_USER       = ${DB_USER}"
echo "DB_PASS       = ${DB_PASS}"
echo "DB_NAME       = ${DB_NAME}"
echo "DB_HOST       = ${DB_HOST}"

create_database
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


# Apache 2
enable_virtualhost
