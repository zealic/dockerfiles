FROM debian:jessie
MAINTAINER zealic <zealic@gmail.com>

RUN apt-get update && apt-get install -y iptables openssl openvpn net-tools tcpdump \
  && apt-get clean && rm -rf /var/lib/apt/lists/*

ADD ./bin/* /usr/local/bin/

EXPOSE 1194/udp

CMD ["/usr/local/bin/run-vpn"]
