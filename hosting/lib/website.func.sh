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
