ARG DEBIAN_VER=10
################################################################################
# Source
################################################################################
FROM debian:$DEBIAN_VER AS source
RUN export BUILD_DEPS=" \
    make gcc pkg-config \
    ca-certificates curl xz-utils \
    libreadline-dev libev-dev libprotobuf-c-dev libseccomp-dev libgnutls28-dev \
    libpam-dev libnl-route-3-dev libwrap0-dev libkrb5-dev libradcli-dev libhttp-parser-dev liblz4-dev" \
  && apt-get update && apt-get install -y $BUILD_DEPS --no-install-recommends && rm -rf /var/lib/apt/lists/*

ENV OCSERV_VER=1.1.5
ENV OCSERV_URL=ftp://ftp.infradead.org/pub/ocserv/ocserv-${OCSERV_VER}.tar.xz
ENV OCSERV_DIR=/ocserv
RUN mkdir $OCSERV_DIR
WORKDIR $OCSERV_DIR
RUN curl -sSL ${OCSERV_URL} | tar --strip-components=1 -C $OCSERV_DIR -xvJf -
RUN ./configure && make && make install
RUN mv /usr/local/sbin/* /usr/local/bin
RUN mkdir -p /etc/ocserv && cp ./doc/sample.config /etc/ocserv/sample.config


################################################################################
# Runtime
################################################################################
FROM debian:$DEBIAN_VER
RUN export DEPS=" \
    bash procps curl gnutls-bin iptables libpam-ldap libradcli4 \
    libev4 libprotobuf-c1 libwrap0 libgssapi-krb5-2 libhttp-parser2.8" \
  && apt-get update && apt-get install -y $DEPS --no-install-recommends && rm -rf /var/lib/apt/lists/*
COPY --from=source /usr/local/bin/* /usr/local/bin/
COPY --from=source /etc/ocserv/sample.config /etc/ocserv/
COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]

EXPOSE 443
CMD ["ocserv", "-c", "/etc/ocserv/ocserv.conf", "-f"]
