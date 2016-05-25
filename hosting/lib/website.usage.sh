#!/bin/bash

. ./etc/global.conf.sh
. ./lib/output.func.sh
. ./lib/common.func.sh

function usage_new_website() {
    outputTitle " Usage :"
    outputTitle "---------"
    outputNotice "${0} -w www.newsite.tld"
    echo ""
}

function usage_clean_website() {
    outputTitle " Usage :"
    outputTitle "---------"
    outputNotice "${0} -w www.newsite.tld"
    echo ""
}
