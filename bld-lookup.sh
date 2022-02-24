#!/bin/bash
# Author: Yevgeniy Goncharov aka xck, http://sys-adm.in
# Collect all BLD DNS IP addresses and will try to resolve target domain with BLD
# What is BLD DNS - https://lab.sys-adm.in

# Sys env / paths / etc
# -------------------------------------------------------------------------------------------\
PATH=$PATH:/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin
SCRIPT_PATH=$(cd `dirname "${BASH_SOURCE[0]}"` && pwd)

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
if [[ $# -eq 0 ]] ; then
    echo 'Set domain name for resolving. Exit.'
    exit 1
else
    RESOLVE=$1
fi

# Actions
# ---------------------------------------------------\
ips=$(dig +short bld.sys-adm.in)

# echo -e "\n----------------------- Starting DNS resolving -----------------------\n"

for ip in ${ips}; do

    Info "\n----------------------- Starting from IP: $ip -----------------------\n"
    nslookup $RESOLVE $ip

    time=`dig @$ip $RESOLVE | awk '/Query time:/ {print " "$4}'`
    echo -e "Response speed: $time ms"

    # echo -e "\n----------------------- Done from IP: $ip -----------------------\n"
done