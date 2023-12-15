#### 51.20.156.125:1081
#auth strong
#flush
#include /conf/51.20.156.125.cfg
#monitor /conf/51.20.156.125.cfg
#socks -p1081 -i172.31.29.171 -e172.31.29.171

rm -rf ./conf
mkdir ./conf


echo 'nscache 65536
nserver 172.31.0.2
nserver 172.31.0.2

config /conf/3proxy.cfg
monitor /conf/3proxy.cfg

log /logs/3proxy-%y%m%d.log D
logformat "L%C - %U [%d/%o/%Y:%H:%M:%S %z] ""%T"" %E %I %O %N/%R:%r"
rotate 60
counter /count/3proxy.3cf

users $/conf/passwd
monitor /conf/passwd

include /conf/counters
include /conf/bandlimiters
' > ./conf/3proxy.cfg



cat list_clean | while read IP
do
    WHITE_IP=`echo $IP | awk '{print $1}'`
    VPC_IP=`echo $IP | awk '{print $2}'`

    shuf -i 20000-30000 -n 100 | while read PORT
    do
        echo -e "\n### ${WHITE_IP}:$PORT\nauth strong\nflush" >> ./conf/3proxy.cfg
        echo -e "include /conf/${WHITE_IP}.$PORT.cfg\nmonitor /conf/${WHITE_IP}.$PORT.cfg" >> ./conf/3proxy.cfg
        echo -e "socks -p$PORT -i$VPC_IP -e$VPC_IP\n" >> ./conf/3proxy.cfg

        echo -e "allow admin" > ./conf/${WHITE_IP}.$PORT.cfg

    done

#    echo "$WHITE_IP"
done

scp -r ./conf ec2-user@16.16.131.221:/tmp

#shuf -i 20000-30000 -n 10
