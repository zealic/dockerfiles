FROM alpine:edge
MAINTAINER zealic <zealic@gmail.com>

RUN export ALPINE_VERSION=edge \
  && export ALPINE_MIRROR_HOST=mirrors.tuna.tsinghua.edu.cn \
  && echo "https://$ALPINE_MIRROR_HOST/alpine/$ALPINE_VERSION/main/" > /etc/apk/repositories \
  && echo "https://$ALPINE_MIRROR_HOST/alpine/$ALPINE_VERSION/community/" >> /etc/apk/repositories

RUN export DNS_VER=1.3.2 \
    && export DNS_URL=https://github.com/shadowsocks/ChinaDNS/releases/download/${DNS_VER}/chinadns-${DNS_VER}.tar.gz \
    && export DNS_FILE=chinadns.tar.gz \
    && export DNS_DIR=chinadns-$DNS_VER \
    && export BUILD_DEPS="musl-dev gcc gawk make libtool" \
    && export RUNTIME_DEPS="curl dnsmasq supervisor" \
    && set -ex \
    && apk add --update $BUILD_DEPS $RUNTIME_DEPS \
    && curl -sSL $DNS_URL | tar xz \
    && curl http://ftp.apnic.net/apnic/stats/apnic/delegated-apnic-latest \
        | grep ipv4 \
        | grep CN \
        | awk -F\| '{printf("%s/%d\n", $4, 32-log($5)/log(2))}' > /etc/chnroute.txt \
    && cd $DNS_DIR \ 
        && ./configure \
        && make install \
        && cd .. \
        && rm -rf $DNS_DIR \
    && apk del --purge $BUILD_DEPS \
    && rm -rf /var/cache/apk/*

ADD ./run-dns /
EXPOSE 53/tcp 53/udp

CMD ["/run-dns"]
