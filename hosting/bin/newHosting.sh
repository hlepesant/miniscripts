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

FULLPATH=$(printf "%s/%s/web" ${WEB_BASE_DIR} ${WEBSITE})

check_exist_new_website ${FULLPATH}

if [[ ${?} -eq 0 ]]; then
    outputError "${FULLPATH} already exist !!"
    outputError "Can't continue. Bye!!"
    exit 1
fi
#echo ${WEBSITE}
#echo ${FULLPATH}

exit 0
