FROM alpine
MAINTAINER zealic <zealic@gmail.com>

ENV BUILD_DEPS="autoconf automake build-base  gawk git iptables libtool linux-headers"
RUN apk add -U $BUILD_DEPS \
    && git clone --recursive https://github.com/WeShadowsocks/ShadowVPN.git \
    && cd ShadowVPN \
    && ./autogen.sh \
    && ./configure --enable-static --sysconfdir=/etc \
    && make install \
    && cd .. \
    && rm -rf ShadowVPN \
    && apk del $BUILD_DEPS

EXPOSE 1123/udp

CMD shadowvpn -c /etc/shadowvpn/server.conf
