#!/bin/bash

## Munin plugin to return how many OpenVPN sessions are active.
## Requirements for OpenVPN server config file:
### status-file $foo
### status-version 2
## Requirements for 'openvpn-users' config stanza for munin-node:
### [openvpn-users]
### env.statusfile "/var/log/openvpn.stat"

if [[ $1 == "config" ]]; then
    echo "graph_title OpenVPN Users"
    echo "graph_vlabel User Count"
    echo "graph_category openvpn"
    echo "user.label Logged In Users"
    exit 0
fi

OVPNSTATUSFILE=$statusfile

if [ ! -e $OVPNSTATUSFILE ]; then
    echo "OpenVPN status file $OVPNSTATUSFILE does not exist"
    exit 1
fi

USERCOUNT=`grep ^CLIENT_LIST $OVPNSTATUSFILE | wc -l`

echo "user.count $USERCOUNT"
exit 0