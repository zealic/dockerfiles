ARG ALPINE_VER=3.10
################################################################################
# Source
################################################################################
FROM alpine:$ALPINE_VER AS source
RUN export DEPS=" \
    curl \
    gcc autoconf make linux-headers \
    musl-dev openssl-dev linux-pam-dev \
    ncurses-dev readline-dev lz4-dev lzo-dev zlib-dev" \
    && apk add $DEPS

ENV TINC_VER=1.1pre17
ENV TINC_URL=https://www.tinc-vpn.org/packages/tinc-${TINC_VER}.tar.gz
ENV TINC_DIR=/tinc
RUN mkdir $TINC_DIR
WORKDIR $TINC_DIR
RUN curl -sSL ${TINC_URL} | tar --strip-components=1 -C $TINC_DIR -xvzf -
RUN ./configure --prefix=/usr/local \
            --sysconfdir=/etc \
            --mandir=/usr/share/man \
            --infodir=/usr/share/info \
            --localstatedir=/var \
            --enable-jumbograms \
            --enable-lzo \
            --enable-zlib
RUN make && make install


################################################################################
# Runtime
################################################################################
FROM alpine:$ALPINE_VER
RUN export DEPS="iptables ncurses readline lzo zlib" \
    && apk add $DEPS
ADD ./entrypoint.sh /
COPY --from=source /usr/local/sbin/* /usr/local/bin/

EXPOSE 655/tcp 655/udp
VOLUME /etc/tinc
ENTRYPOINT ["/entrypoint.sh"]
