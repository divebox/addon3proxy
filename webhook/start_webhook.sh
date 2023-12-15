killall webhook 2>/dev/null
sleep 1
webhook -hooks /home/ubuntu/addon3proxy/webhook/hooks.json -verbose -logfile /home/ubuntu/addon3proxy/webhook/hook.log &

