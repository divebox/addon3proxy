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



cat proxyip.list | while read IP
do
    ls -1 /etc/3proxy/conf/ | grep ".cfg$" | awk -F'.' '{print $1"."$2"."$3"."$4}' | uniq | grep -x $IP > /dev/null
    if [ $? -eq 0 ]
    then
        echo "this ip already used"
        continue
    fi

    WHITE_IP=`echo $IP | awk '{print $1}'`
    VPC_IP=`echo $IP | awk '{print $2}'`

    shuf -i 20000-30000 -n 100 | while read PORT
    do
        echo -e "\n### ${WHITE_IP}:$PORT\nauth strong\nflush" >> ./conf/3proxy.cfg
        echo -e "include /conf/${WHITE_IP}.$PORT.cfg\nmonitor /conf/${WHITE_IP}.$PORT.cfg" >> ./conf/3proxy.cfg
        echo -e "socks -p$PORT -i$VPC_IP -e$VPC_IP\n" >> ./conf/3proxy.cfg

        echo -e "allow admin" > ./conf/${WHITE_IP}.$PORT.cfg

    done
done
