#!/bin/bash

. ./etc/global.conf.sh
. ./etc/hosting.conf.sh

PWGEN=/usr/bin/pwgen


function make_password() {
    echo $(${PWGEN} ${PASSWORD_MIN_LENGTH} -1)
}
