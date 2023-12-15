#!/bin/sh

IP=`echo $PROXY | awk -F':' '{print $1}'`
PORT=`echo $PROXY | awk -F':' '{print $2}'`

if [ -z "${IP}" ]; then echo "ip addr is empty"; exit 1; fi
if [ -z "${PORT}" ]; then echo "port is empty"; exit 1; fi

touch passwd

#grep "^${USER}:CL:${PASS}$" passwd
#if [ $? -eq 1 ]; then
#    echo "${USER}:CL:${PASS}" >> passwd
#else
#    echo "user $USER already in passwd"
#fi

touch $IP.$PORT.cfg
grep "^allow ${USER}$" $IP.$PORT.cfg > /dev/null
if [ $? -eq 0 ]; then
    grep -v "^allow ${USER}$" $IP.$PORT.cfg > $IP.$PORT.cfg.$$
    mv $IP.$PORT.cfg.$$ $IP.$PORT.cfg
fi


#cat $IP.cfg > $IP.cfg.$$
#cat $IP.cfg.$$ | sort | uniq > $IP.cfg
#echo "user $USER added"
#grep "^allow ${USER}$" $IP.cfg

#echo $0
#echo $1
#echo $2

#echo $PROXY_IP > 123.log
#echo $1 >> 123.log
