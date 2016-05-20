#!/bin/bash


function check_sudo() {
    if [[ -z "${SUDO_USER}" ]]; then
        outputError "Please use sudo !!"
        exit 99
    fi
}
