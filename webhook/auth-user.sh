#!/bin/sh

IP=`echo $PROXY | awk -F':' '{print $1}'`
PORT=`echo $PROXY | awk -F':' '{print $2}'`

if [ -z "${IP}" ]; then echo "Error! ip addr is empty"; exit 1; fi
if [ -z "${PORT}" ]; then echo "Error! port is empty"; exit 1; fi
if [ -z "${USER}" ]; then echo "Error! user is empty"; exit 1; fi
if [ -z "${PASS}" ]; then echo "Error! password is empty"; exit 1; fi



touch passwd
grep "^${USER}:CL:${PASS}$" passwd > /dev/null
if [ $? -eq 1 ]; then
    echo "${USER}:CL:${PASS}" >> passwd
else
    echo "user $USER already in passwd"
fi

touch $IP.cfg
grep "^allow ${USER}$" $IP.$PORT.cfg > /dev/null
if [ $? -eq 1 ]; then
    echo "allow $USER" >> $IP.$PORT.cfg
else
    echo "user $USER already allowed"
fi

