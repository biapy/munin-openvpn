#!/bin/bash

# Graph the transfer in bytes of each user

IFS=$'\n'
statusfile=/var/log/openvpn/status.log
client_list="`grep ^CLIENT_LIST $statusfile`"

if [[ $1 == "config" ]]; then
    echo "graph_title OpenVPN User Transfer Rate"
    echo "graph_order down up"
    echo "graph_vlabel Bytes Received / Bytes Sent"
    echo "graph_category openvpn"
    for current_line in $client_list; do
        current_user=`echo $current_line | cut -d, -f2`
        echo "$current_user.label $current_user"
        echo "$current_user.type COUNTER"
        echo "${current_user}_down.graph no"
        echo "${current_user}_up.negative down"
    done
    exit 0
fi

for current_line in $client_list; do
    current_user=`echo $current_line | cut -d, -f2`
    current_dl=`echo $current_line | cut -d, -f5`
    echo "${current_user}_down.value  $current_dl"
    current_ul=`echo $current_line | cut -d, -f6`
    echo "${current_user}_up.value $current_ul"
done
