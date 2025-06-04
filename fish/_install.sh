#!/bin/bash

pwd=$(
    cd "$(dirname "$0")" || exit
    pwd
)

source "${pwd}/../_basic/log_color.sh"
source "${pwd}/../_basic/_basic.sh"

function main() {
    local name=$(basename ${pwd})
    log_title "${name}"

    package_install "fish"
    if [ ! -d "${xconf}/fish" ]; then
        try_link_dir "${pwd}" "${xconf}/fish"
        log_installing "${name}_conf"
    else
        log_installed "${name}_conf"
    fi
    log_succ "${name}"
}


main "$@"