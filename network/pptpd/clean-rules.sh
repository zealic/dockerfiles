#!/bin/bash
IPS=$(iptables -t nat -L DOCKER | grep gre | grep -o -E '([0-9]+\.){3}[0-9]+')
for ip in $IPS ; do
  ping -c 3 -i 0.25 $ip
  if [ $? -ne 0 ]; then
    echo Removing $ip GRE rule..
    iptables -t nat -D DOCKER -p gre -j DNAT --to-destination $ip
  fi
done
