#!/bin/bash

# Graph the transfer in bytes of each user

IFS=$'\n'
statusfile=/var/log/openvpn/status.log
client_list="`grep ^CLIENT_LIST $statusfile`"

if [[ $1 == "config" ]]; then
    echo "graph_title OpenVPN User Transfer Rate"
    echo "graph_vlabel Bytes Received / Bytes Sent"
    echo "graph_category openvpn"
    echo "graph_info Show the data transfer over the VPN per user."
    for current_line in $client_list; do
        current_user=`echo $current_line | cut -d, -f2`
        echo "${current_user}_received.label ${current_user}"
        echo "${current_user}_received.type DERIVE"
	echo "${current_user}_received.min 0"
	echo "${current_user}_received.graph no"
	echo "${current_user}_received.draw LINE2"
        echo "${current_user}_sent.label ${current_user}"
        echo "${current_user}_sent.type DERIVE"
	echo "${current_user}_sent.min 0"
	echo "${current_user}_sent.negative ${current_user}_received"
	echo "${current_user}_sent.draw LINE2"
    done
    exit 0
fi

for current_line in $client_list; do
    current_user=`echo $current_line | cut -d, -f2`
    current_received=`echo $current_line | cut -d, -f5`
    current_sent=`echo $current_line | cut -d, -f6`
    echo "${current_user}_received.value $current_received"
    echo "${current_user}_sent.value $current_sent"
done
