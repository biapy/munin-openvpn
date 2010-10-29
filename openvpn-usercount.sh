#!/bin/bash

## Munin plugin to return how many OpenVPN sessions are currently connected to an OpenVPN server.
## Requirements for OpenVPN server config file:
### status /var/log/openvpn/status.log 60
### status-version 2
## Requirements for 'openvpn_usercount' config stanza for munin-node:
### [openvpn_usercount]
### env.statusfile "/var/log/openvpn.stat"

if [[ $1 == "config" ]]; then
    echo "graph_title OpenVPN Users"
    echo "graph_vlabel User Count"
    echo "graph_category openvpn"
    echo "user.label Logged In Users"
    exit 0
fi

OVPNSTATUSFILE=$statusfile

if [ -z $OVPNSTATUSFILE ]; then
    echo "The environment variable setting the status file is not set."
    exit 1
fi

if [ ! -e $OVPNSTATUSFILE ]; then
    echo "OpenVPN status file $OVPNSTATUSFILE does not exist"
    exit 1
fi

USERCOUNT=`grep ^CLIENT_LIST $OVPNSTATUSFILE | wc -l`

echo "user.value $USERCOUNT"
exit 0
