#!/bin/sh
DIRT_DNS_ADDR=${DIRT_DNS_ADDR:-223.5.5.5}
SAFE_DNS_ADDR=${SAFE_DNS_ADDR:-8.8.4.4}

mkdir /etc/supervisor.d 2>/dev/null
if [ ! -f /etc/supervisor.d/chinadns.ini ];
then
  cat > /etc/supervisor.d/chinadns.ini <<EOF
[program:chinadns]
priority = 100
command = chinadns -b 127.0.0.1
                   -c /etc/chnroute.txt
                   -m
                   -p 2053
                   -s $DIRT_DNS_ADDR,$SAFE_DNS_ADDR
                   -y 0.3

[program:dnsmasq]
priority = 200
command = dnsmasq --cache-size=25000
                  --conf-file=/dev/null
                  --keep-in-foreground
                  --log-facility=/dev/stdout
                  --no-resolv
                  --server=127.0.0.1#2053
                  --user=root
EOF
fi

exec supervisord -n
