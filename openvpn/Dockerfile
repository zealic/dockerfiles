# Alpine network performance better than Debian jessie
FROM alpine:3.2
MAINTAINER zealic <zealic@gmail.com>

RUN echo "http://dl-4.alpinelinux.org/alpine/edge/community/" >> /etc/apk/repositories \
  && apk add --update openvpn iptables bash easy-rsa tcpdump mtr \
  && ln -s /usr/share/easy-rsa/easyrsa /usr/local/bin \
  && rm -rf /tmp/* /var/tmp/* /var/cache/apk/*

ADD ./bin/* /usr/local/bin/

ENV OPENVPN /etc/openvpn

EXPOSE 1194/udp

ENTRYPOINT ["/usr/local/bin/run-vpn"]
