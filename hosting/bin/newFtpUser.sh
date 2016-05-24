#!/bin/bash

. ./etc/hosting.conf.sh
. ./lib/ftpserver.func.sh


check_sudo

if [[ $# -eq 0 ]]; then
    usage_new_ftp_user
    exit 1
fi

while getopts ":w:a:u:d:f:" opt; do
    case $opt in
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
    usage_new_ftp_user
    exit 1
fi



FULLPATH=$(printf "%s/%s" ${WEB_BASE_DIR} ${WEBSITE})
VHOST_FILE=$(printf "%s/vhost.conf" ${FULLPATH})

DOCUMENTROOT=$(get_ftp_home)

echo "FTP_HOME = ${DOCUMENTROOT}"

FTP_PASS=$(make_password)

outputInfo "Create FTP user : ${FTP_USER}"
ftp_create_user

outputInfo " Resume"
outputInfo "--------"

outputTitle "FTP Access"
echo "FTP_USER       = ${FTP_USER}"
echo "FTP_PASS       = ${FTP_PASS}"
echo "FTP_HOME       = ${DOCUMENTROOT}"
