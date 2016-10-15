#!/bin/bash 
# name   : Signal strength for home router running some kind of UNIX system with SSH enabled
# author : Jakub Olczyk <jakub.olczyk@openmailbox.org>
# license: GPLv3+ see www.gnu.org/licenses/gpl.html
set -euo pipefail 
IFS=$'\n\t'

ROUTER_ADDRESS=172.16.0.1

function dbm_signal () {
    ssh root@$1 "grep wlan0 /proc/net/wireless | tail -n1 | awk '{print \$4;}'| tr '.' ' '" || exit 1
    exit 0
}

function convert_to_percent () {
    dBm=$1
    percent=$(python -c "print min((max((2 * ($dBm + 100),0)), 100))")
    echo "$percent%"
    exit 0
}

SIGNAL=$(dbm_signal $ROUTER_ADDRESS)
convert_to_percent $SIGNAL
