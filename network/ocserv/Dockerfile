ARG ALPINE_VER=3.9
################################################################################
# Source
################################################################################
FROM alpine:$ALPINE_VER AS source
RUN export DEPS=" \
    tar musl-dev iptables gnutls-dev readline-dev protobuf-dev \
    protobuf-c-dev nss-dev linux-pam-dev libev-dev \
    libnl3-dev lz4-dev libseccomp-dev xz openssl gcc autoconf make linux-headers" \
    && apk add $DEPS

ENV OCSERV_VER=0.12.3
ENV OCSERV_URL=ftp://ftp.infradead.org/pub/ocserv/ocserv-${OCSERV_VER}.tar.xz
ENV OCSERV_DIR=/ocserv
RUN mkdir $OCSERV_DIR
WORKDIR $OCSERV_DIR
RUN wget -qO- ${OCSERV_URL} | tar --strip-components=1 -C $OCSERV_DIR -xvJf -
RUN ./configure && make && make install
RUN mv /usr/local/sbin/* /usr/local/bin
RUN mkdir -p /etc/ocserv && cp ./doc/sample.config /etc/ocserv/sample.config


################################################################################
# Runtime
################################################################################
FROM alpine:$ALPINE_VER
RUN export DEPS=" \
    bash gnutls-utils iptables openssl libnl3 libseccomp readline \
    protobuf-c nss linux-pam libev lz4-libs" \
    && apk add $DEPS
COPY --from=source /usr/local/bin/* /usr/local/bin/
COPY --from=source /etc/ocserv/sample.config /etc/ocserv/
COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]

EXPOSE 443
CMD ["ocserv", "-c", "/etc/ocserv/ocserv.conf", "-f"]
