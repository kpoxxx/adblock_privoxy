#!/opt/bin/bash

opkg update
opkg install bash wget sed privoxy
cd /opt/etc/privoxy/
rm ./config
wget http://files.ryzhov-al.ru/Routers/adblock-plus/config
wget http://files.ryzhov-al.ru/Routers/adblock-plus/privoxy-blocklist_0.2.sh
chmod +x ./privoxy-blocklist_0.2.sh
./privoxy-blocklist_0.2.sh

echo "#!/bin/sh
[ \"\$table\" != "nat" ] && exit 0   # check the table name
iptables -t nat -A PREROUTING -s 192.168.1.0/24 -p tcp -m tcp --dport 80 -j REDIRECT --to-ports 3128" >> /opt/etc/ndm/netfilter.d/054-adblock-nat.sh

chmod +x /opt/etc/ndm/netfilter.d/054-adblock-nat.sh
