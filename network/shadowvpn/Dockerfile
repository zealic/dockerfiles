FROM alpine
MAINTAINER zealic <zealic@gmail.com>

ENV BUILD_DEPS="autoconf automake build-base gawk git libtool linux-headers"
RUN apk add -U $BUILD_DEPS iptables \
    && git clone --recursive https://github.com/WeShadowsocks/ShadowVPN.git \
    && cd ShadowVPN \
    && ./autogen.sh \
    && ./configure --enable-static --sysconfdir=/etc \
    && make install \
    && cd .. \
    && rm -rf ShadowVPN \
    && apk del $BUILD_DEPS

ADD ./bin/* /usr/local/bin/

EXPOSE 1123/udp

ENTRYPOINT ["/usr/local/bin/run-vpn"]
