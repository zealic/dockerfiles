FROM debian:jessie
MAINTAINER zealic <zealic@gmail.com>

RUN apt-get update && apt-get install -y iptables openssl openvpn net-tools mtr-tiny tcpdump \
  && apt-get clean && rm -rf /var/lib/apt/lists/*

ADD ./bin/* /usr/local/bin/

ENV OPENVPN /etc/openvpn

EXPOSE 1194/udp

CMD ["/usr/local/bin/run-vpn"]
