FROM alpine:3.9 as source
ENV SHADOWSOCKS_VER=3.2.4
ENV SHADOWSOCKS_URL=https://github.com/shadowsocks/shadowsocks-libev/archive/v$SHADOWSOCKS_VER.tar.gz
RUN export SS_DIR=shadowsocks-libev-$SHADOWSOCKS_VER \
    && export SS_DEP="autoconf build-base curl libtool linux-headers openssl-dev" \
    && export DEPS="bash" \
    && apk add $DEPS $SS_DEP \
    && curl -sSL $SS_URL | tar xz
WORKDIR $SS_DIR
RUN ./configure && make install

FROM alpine:3.9
COPY --from=source /usr/local/bin/* /usr/local/bin/
ADD ./run-ss /

ENTRYPOINT ["/run-ss"]
