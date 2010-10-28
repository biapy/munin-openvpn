#!/bin/sh

if [[ $1 == "config" ]]; then
    echo "graph_title OpenVPN Users"
    echo "graph_vlabel User Count"
    echo "user.label Logged In Users"
    exit 0
fi

USERCOUNT=0

OVPNSTATUSFILE=$statusfile
USERCOUNT=`grep ^CLIENT_LIST $OVPNSTATUSFILE | wc -l`

echo "user.count $usercount"