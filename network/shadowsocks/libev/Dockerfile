FROM alpine:3.3
MAINTAINER zealic <zealic@gmail.com>

RUN export ALPINE_VERSION=3.3 && export ALPINE_MIRROR_HOST=mirrors.ustc.edu.cn \
  && echo "https://$ALPINE_MIRROR_HOST/alpine/v$ALPINE_VERSION/main/" > /etc/apk/repositories \
  && echo "https://$ALPINE_MIRROR_HOST/alpine/v$ALPINE_VERSION/community/" >> /etc/apk/repositories

RUN export SS_VER=2.4.6 \
    && export SS_URL=https://github.com/shadowsocks/shadowsocks-libev/archive/v$SS_VER.tar.gz \
    && export SS_DIR=shadowsocks-libev-$SS_VER \
    && export SS_DEP="autoconf build-base curl libtool linux-headers openssl-dev" \
    && export DEPS="bash" \
    && set -ex \
    && apk add --update $DEPS $SS_DEP \
    && curl -sSL $SS_URL | tar xz \
    && cd $SS_DIR \ 
        && ./configure \
        && make install \
        && cd .. \
        && rm -rf $SS_DIR \
    && apk del --purge $SS_DEP \
    && rm -rf /var/cache/apk/*

ADD ./run-ss /

ENTRYPOINT ["/run-ss"]
