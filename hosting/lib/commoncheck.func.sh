#!/bin/bash


WGET=/usr/bin/wget
CURL=/usr/bin/curl
TAR=/bin/tar
UNZIP=/usr/bin/unzip
SED=/bin/sed


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
