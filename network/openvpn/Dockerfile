ARG ALPINE_VER=3.9
################################################################################
# Source
################################################################################
FROM alpine:$ALPINE_VER AS source
RUN export DEPS=" \
    gcc autoconf make linux-headers \
    musl-dev openssl-dev lz4-dev lzo-dev linux-pam-dev" \
    && apk add $DEPS

ENV OPENVPN_VER=2.4.7
ENV OPENVPN_URL=https://swupdate.openvpn.org/community/releases/openvpn-${OPENVPN_VER}.tar.gz
ENV OPENVPN_DIR=/openvpn
RUN mkdir $OPENVPN_DIR
WORKDIR $OPENVPN_DIR
RUN wget -qO- ${OPENVPN_URL} | tar --strip-components=1 -C $OPENVPN_DIR -xvzf -
RUN ./configure && make && make install


################################################################################
# Runtime
################################################################################
FROM alpine:$ALPINE_VER
RUN export DEPS="iptables bash easy-rsa openssl lz4-libs lzo linux-pam" \
    && apk add $DEPS
COPY --from=source /usr/local/ /usr/local/
COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
ENV OPENVPN /etc/openvpn
EXPOSE 1194/udp
