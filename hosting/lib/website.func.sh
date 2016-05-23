#!/bin/bash

. ./etc/global.conf.sh
. ./lib/output.func.sh
. ./lib/common.func.sh
. ./lib/check.func.sh


function usage_new_website() {
    outputTitle " Usage :"
    outputTitle "---------"
    outputNotice "${0} -w www.newsite.tld -a [application] -u [mysql user name]"
    echo ""
    outputNotice "Supported applications :"
    outputNotice "------------------------"
    outputNotice " - wordrpess"
    outputNotice " - prestashop"
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

    mkdir -p ${DOCUMENT_ROOT}
}

function get_web_application() {
    local url_arch=${1}
    local output=${2}

    if [[ -x ${WGET} ]]; then
        $(${WGET} --output-document=/tmp/${output} ${url_arch})
    elif [[ -x ${CURL} ]]; then
        $(${CURL} -o /tmp/${ARCHIVE} --url ${url_arch})
    fi
}

function make_virtualhost_new_website() 
{
    case ${APP} in
        'wordpress')
            cp ./etc/wordpress.template ${FULLPATH}/vhost.conf 
        ;;
        'prestashop')
            cp ./etc/prestashop.template ${FULLPATH}/vhost.conf 
        ;;
        'magento')
            cp ./etc/magento.template ${FULLPATH}/vhost.conf 
        ;;
        *)
            cp ./etc/vhostbasic.template ${FULLPATH}/vhost.conf 
        ;;
    esac

    local escapedpath=$(echo ${FULLPATH}|${SED} -e 's/\//\\\//g')

    ${SED} -i "s/#SERVER_NAME#/${WEBSITE}/g" ${FULLPATH}/vhost.conf 
    ${SED} -i "s/#DOCUMENT_ROOT#/${escapedpath}/g" ${FULLPATH}/vhost.conf 
}


function unpack_source()
{
    case ${APP} in
        'wordpress')
            ${TAR} xfz /tmp/${WORDPRESS_ARCHIVE} --directory=${FULLPATH}
            sync
            rm -f /tmp/${WORDPRESS_ARCHIVE}
        ;;
        'prestashop')
            ${UNZIP} /tmp/${PRESTASHOP_ARCHIVE} -d ${FULLPATH}/
            sync
            rm -f /tmp/${PRESTASHOP_ARCHIVE}
        ;;
        'magento')
            ${UNZIP} /tmp/${MAGENTO_ARCHIVE} -d ${FULLPATH}/
            sync
            rm -f /tmp/${MAGENTO_ARCHIVE}
        ;;
        *)
            echo "nothing to do"
        ;;
    esac
    
}

function enable_virtualhost()
{
    ${LN} -s ${FULLPATH}/vhost.conf ${APACHE_SITES_ENABLED}/${WEBSITE}.conf
}
