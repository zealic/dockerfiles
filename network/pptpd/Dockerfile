FROM debian:jessie
MAINTAINER zealic <zealic@gmail.com>

RUN apt-get update && apt-get install -y iptables pptpd \
  && apt-get clean && rm -rf /var/lib/apt/lists/*

ADD ./etc/* /etc/
ADD ./etc/ppp /etc/ppp/
ADD ./bin/* /usr/local/bin/

EXPOSE 1723/tcp

VOLUME ["/etc"]

CMD ["/usr/local/bin/run-vpn"]
