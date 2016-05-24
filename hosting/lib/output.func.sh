#!/bin/bash


function outputOk() {
    local msg=${1}
    echo -e "\e[92m${msg}\e[0m"
}

function outputNotice() {
    local msg=${1}
    echo -e "\e[0m${msg}\e[0m"
}

function outputInfo() {
    local msg=${1}
    echo -e "\e[36m${msg}\e[0m"
}

function outputWarning() {
    local msg=${1}
    echo -e "\e[93m${msg}\e[0m"
}

function outputError() {
    local msg=${1}
    echo -e "\e[31m${msg}\e[0m "
}

function outputTitle() {
    local msg=${1}
    echo -e "\e[1m${msg}\e[21m"
}
