#!/bin/bash

. ./etc/global.conf.sh
. ./etc/hosting.conf.sh

function make_password() {
    echo $(${PWGEN} ${PASSWORD_MIN_LENGTH} -1)
}
