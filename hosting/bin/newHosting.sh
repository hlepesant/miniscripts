#!/bin/bash

. ./etc/hosting.conf.sh
. ./lib/website.func.sh


check_sudo

if [[ $# -eq 0 ]]; then
    usage_new_website
    exit 1
fi

while getopts ":w:a:" opt; do
    case $opt in
        a)
            APP=${OPTARG}
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

case ${APP} in
    'wordpress')
        APP_SOURCE=${WORDPRESS_URL_ARCHIVE}
        WEBDIR='wordpress'
        ARCHIVE='wordpress.tar.gz'
        get_web_application ${APP_SOURCE} ${ARCHIVE}
    ;;
    'prestashop')
        APP_SOURCE=${PRESTASHOP_URL_ARCHIVE}
        WEBDIR='perstashop'
        ARCHIVE='perstashop.zip'
        get_web_application ${APP_SOURCE} ${ARCHIVE}
    ;;
    *)
        APP_SOURCE=''
        WEBDIR='web'
        APP='none'
    ;;
esac

FULLPATH=$(printf "%s/%s" ${WEB_BASE_DIR} ${WEBSITE})
DOCUMENT_ROOT=$(printf "%s/%s/%s" ${WEB_BASE_DIR} ${WEBSITE} ${WEBDIR})

check_exist_new_website ${DOCUMENT_ROOT}

if [[ ${?} -eq 0 ]]; then
    outputError "${FULLPATH} already exist !!"
    outputError "Can't continue. Bye!!"
    exit 1
fi

echo ${WEBSITE}
echo ${FULLPATH}
echo ${DOCUMENT_ROOT}
echo ${APP}
echo ${APP_SOURCE}
echo ${WEBDIR}

make_documentroot_new_website

make_virtualhost_new_website

unpack_source
