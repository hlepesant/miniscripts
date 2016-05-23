#!/bin/bash

. ./etc/global.conf.sh

function check_sudo() {
    if [[ -z "${SUDO_USER}" ]]; then
        outputError "Please use sudo !!"
        exit 99
    fi
}

function check_downloader() {
    if [[ ! -x ${WGET} && ! -x ${CURL} ]]; then
        outputError "Please install curl or wget"
        outputError "Can't continue. Bye!!"
        exit 1
    fi
}

function check_uncompressor() {

    if [[ ! -x ${TAR} && ! -x ${UNZIP} ]]; then
        outputError "Please install tar or unzip"
        outputError "Can't continue. Bye!!"
        exit 1
    fi
}
