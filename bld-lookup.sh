#!/bin/bash
# Author: Yevgeniy Goncharov aka xck, http://sys-adm.in
# Collect all BLD DNS IP addresses and will try to resolve target domain with every IP BLD
# What is BLD DNS - https://lab.sys-adm.in

# Sys env / paths / etc
# -------------------------------------------------------------------------------------------\
PATH=$PATH:/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin
SCRIPT_PATH=$(cd `dirname "${BASH_SOURCE[0]}"` && pwd); cd ${SCRIPT_PATH}

# Args and Vars
# ---------------------------------------------------\

usage() {
    echo -e "\nUse script with arguments:
    -d <checking domain name>
    -l <path to domain resolvers list>
    "
    exit 0
}

# Checks arguments
while [[ "$#" -gt 0 ]]; do
    case $1 in
        -d|--domain) _DOMAIN=1 _DOMAIN_DATA=$2; ;;
        -l|--list) _LIST=1 _LIST_DATA=$2; shift ;;
        # -h|--help) usage ;; 
        # *) usage ;;
    esac
    shift
done

if [[ "${_DOMAIN}" -eq "1" ]]; then
    if [[ -z "${_DOMAIN_DATA}" ]]; then
        usage
    fi
    RESOLVE="${_DOMAIN_DATA}"
else
    usage
fi

if [[ "${_LIST}" -eq "1" ]]; then
    if [[ -z "${_LIST_DATA}" ]]; then
        echo "Set custom list please. Exit. Bye."
        exit 0
    fi
    DOMAINs=`cat ${_LIST_DATA}`
else
    # Domain max days expires
    DOMAINs=`cat ${SCRIPT_PATH}/domains.txt`
fi

# Initial variables
# ---------------------------------------------------\
Info() {
    echo -en "${1}${green}${2}${nc}\n"
}

space() { 
    echo -e ""
}

# Checking arguments
# ---------------------------------------------------\
# if [[ -z "$1" ]] ; then
#     # echo 'Set domain name for resolving. Exit.'
#     usage
#     exit 1
# else
#     RESOLVE=$1
# fi

# Actions
# ---------------------------------------------------\
for d in ${DOMAINs}; do

    Info "\n----------------------- Working with domain name: ${d} -----------------------"
    ips=$(dig +short ${d})

    for ip in ${ips}; do

        Info "\n----------------------- IP - ${ip}:\n"
        nslookup ${RESOLVE} ${ip}

        time=`dig @${ip} ${RESOLVE} | awk '/Query time:/ {print " "$4}'`
        echo -e "Response speed: ${time} ms"

        # echo -e "\n----------------------- Done from IP: $ip -----------------------\n"
    done

done


