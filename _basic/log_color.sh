#!/bin/bash

ccode="30"
cstyle=""
foreground=38

function get_ccode() {
    local name="$1"
    case "${name}" in
    "black") ccode=30 ;;
    "red") ccode=31 ;;
    "green") ccode=32 ;;
    "yellow") ccode=33 ;;
    "blue") ccode=34 ;;
    "magenta") ccode=35 ;;
    "cyan") ccode=36 ;;
    "white") ccode=37 ;;
        # extend by 256
    "brown") ccode=52 ;;
    "purple") ccode=93 ;;
    "orange") ccode=202 ;;
    "pink") ccode=206 ;;
    *) ccode=37 ;;
    esac
}

function get_foreground_ccode() {
    local name="$1"
    case "${name}" in
    "black") foreground=40 ;;
    "red") foreground=41 ;;
    "green") foreground=42 ;;
    "yellow") foreground=43 ;;
    "blue") foreground=44 ;;
    "magenta") foreground=45 ;;
    "cyan") foreground=46 ;;
    "white") foreground=47 ;;
    *) foreground=40 ;;
    esac
}

function get_cstyle() {
    local name="$1"
    case "${name}" in
    "") cstyle="" ;;
    "b") cstyle="1;" ;;
    "i") cstyle="3;" ;;
    "st") cstyle="9;" ;;
    *) cstyle="" ;;
    esac
}

function i_echo() {
    echo -e "\\033[${cstyle}${ccode}m$*\\033[m"
}

function i_echo_nowarp() {
    echo -en "\\033[${cstyle}${ccode}m$*\\033[m"
}

#================= echo rainbow ==============
rcindex=0
rccolors=(196 208 226 118 46 48 51 33 21 93 201 198)
rcnum=${#rccolors[@]}
function log_rainbow() {
    foreground=38
    text="$1"
    for ((i = 0; i < ${#text}; i++)); do
        rccode=${rccolors[$rcindex]}
        rcindex=$((rcindex + 1))
        rcindex=$((rcindex % rcnum))
        character=${text:i:1}
        echo -en "\033[${foreground};5;${rccode}m${character}\033[0m"
    done
    echo ""
    return
}
#=============================================

#================= index count ===============
pkg_index=0

function set_step_total() {
    step_total="$1"
}

function _log() {
    get_cstyle "$1"
    get_ccode "$2"
    i_echo_nowarp "$3"
    get_ccode "$4"
}

function log_title() {
    _log "b" "cyan" "" "cyan"
    local name="$1"
    pkg_index=$((pkg_index + 1))

    i_echo "#======== [$pkg_index] INSTALL $name ========#"
}


function log_succ() {
    _log "" "green" "  ✅  " "white"
    i_echo "$*"
}

function log_err() {
    _log "" "red" "  ⛔ " "white"
    i_echo "$*"
}

function log_info() {
    _log "" "white" "[info] " "white"
    i_echo "$*"
}

function log_warn() {
    _log "" "yellow" "[warn] " "yellow"
    i_echo "$*"
}

function log_installed() {
    log_info "$* has been installed, skip" 
}

function log_installing() {
    log_info "$* is installing"
}
#=============================================
