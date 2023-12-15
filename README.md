# addon3proxy
1. Поднимаем VPS с Ubuntu 22, добавляем дополнительные ip адреса, получаем список ip адресов, на которых буду слушать наши прокси. Подразумевается что мы работаем от дефолтного юзера ubuntu

2. Клоним репу, билдим и устанавливаем 3proxy:
git clone https://github.com/divebox/addon3proxy.git
cd addon3proxy/3proxy
ln -s Makefile.Linux Makefile
make
sudo make install
cd ..

3. Сохраняем список ip в файл ./scripts/proxyip.list и генерируем конфиги для 3proxy, после чего запускаем сервис
cd ./scripts
echo -e “135.125.190.111\n51.89.114.147\n51.89.114.148” > proxyip.list
bash gen_config.sh
mv ./conf/* /etc/3proxy/conf
systemctl start 3proxy
cd ..

4. Открываем на редактирование scripts/hook.json, находим там закомментированный блок "trigger-rule", удаляем “#” и прописываем туда ip адрес сервера с админкой

5. Устанавливаем и запускаем webhook (https://github.com/adnanh/webhook)
sudo apt-get install webhook
bash start_webhook.sh

