#!/bin/bash

pwd=$(
    cd "$(dirname "$0")" || exit
    pwd
)

source "${pwd}/_basic/log_color.sh"

function main() {
    log_rainbow "#==========   NO ARCH CONFIG   ==========#"
    
    find ${pwd} -mindepth 1 -maxdepth 1 -type d | while read -r dir; do
        if [ -f "${dir}/_install.sh" ]; then
            sh "${dir}/_install.sh"
        fi
    done
    
    log_rainbow "#===============   END   ================#"
}


main "$@"
