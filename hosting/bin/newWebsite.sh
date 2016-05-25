#!/bin/bash

. ./etc/hosting.conf.sh
. ./lib/website.func.sh


check_sudo

if [[ $# -eq 0 ]]; then
    usage_new_website
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


if [[ -z ${WEBSITE} || -z ${FTP_USER} ]]; then
    usage_new_webiste
    exit 1
fi

WEBDIR='web'
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
