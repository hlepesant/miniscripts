#!/bin/bash

. ./etc/global.conf.sh
. ./lib/output.func.sh
. ./lib/common.func.sh
. ./lib/check.func.sh



PUREPW=/usr/bin/pure-pw


function usage_new_ftp_user()
{
    outputTitle " Usage :"
    outputTitle "---------"
    outputNotice "${0} -w www.newsite.tld -f ftpusername"
    echo ""
}

function ftp_create_user()
{
    (echo "${FTP_PASS}";echo "${FTP_PASS}")|${PUREPW} useradd ${FTP_USER} -d ${DOCUMENTROOT} -u www-data -g www-data
    
    ${PUREPW} mkdb
}

function ftp_drop_user()
{
    local ftpus=$( ${PUREPW} list |${GREP} -e "${DOCUMENTROOT}"|${AWK} '{print $1}' )

    for ftpu in "${ftpus[@]}"
    do
        ${PUREPW} userdel ${ftpu}
    done
    
    ${PUREPW} mkdb

}

function get_ftp_home()
{
    ${GREP} DocumentRoot  ${VHOST_FILE} |${AWK} '{print $NF}'
}
