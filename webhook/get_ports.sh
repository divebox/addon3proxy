#!/bin/sh

if [ -z "${IP}" ]; then echo "ip addr is empty"; exit 1; fi

PORTS=`ls -1 | grep ".cfg$" | grep $IP | awk -F'.' '{print $5}'`
jq -c -n --arg inarr "${PORTS}" '{ ports: $inarr | split("\n") }'
