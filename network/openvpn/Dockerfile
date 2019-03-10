# Alpine network performance better than Debian jessie
ARG ALPINE_VER=3.9
FROM alpine:${ALPINE_VER}

RUN apk add openvpn iptables bash easy-rsa tcpdump mtr \
  && ln -s /usr/share/easy-rsa/easyrsa /usr/local/bin \
  && rm -rf /tmp/* /var/tmp/* /var/cache/apk/*

ADD ./bin/* /usr/local/bin/

ENV OPENVPN /etc/openvpn

EXPOSE 1194/udp

ENTRYPOINT ["/usr/local/bin/run-vpn"]
