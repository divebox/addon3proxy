#!/bin/sh

IP=`echo $PROXY | awk -F':' '{print $1}'`
PORT=`echo $PROXY | awk -F':' '{print $2}'`

if [ -z "${IP}" ]; then echo "Error! ip addr is empty"; exit 1; fi
if [ -z "${PORT}" ]; then echo "Error! port is empty"; exit 1; fi
if [ -z "${USER}" ]; then echo "Error! user is empty"; exit 1; fi
if [ -z "${PASS}" ]; then echo "Error! password is empty"; exit 1; fi

touch passwd

touch $IP.$PORT.cfg
grep "^allow ${USER}$" $IP.$PORT.cfg > /dev/null
if [ $? -eq 0 ]; then
    grep -v "^allow ${USER}$" $IP.$PORT.cfg > $IP.$PORT.cfg.$$
    mv $IP.$PORT.cfg.$$ $IP.$PORT.cfg
fi

