ARG ALPINE_VER=3.9
################################################################################
# Source
################################################################################
FROM alpine:$ALPINE_VER AS source
RUN export DEPS=" \
    curl tar musl-dev gcc make libtool" \
    && apk add $DEPS
ENV CHINADNS_VER=1.3.2
ENV CHINADNS_URL=https://github.com/shadowsocks/ChinaDNS/releases/download/${CHINADNS_VER}/chinadns-${CHINADNS_VER}.tar.gz
ENV CHINADNS_DIR=/chinadns
RUN mkdir $CHINADNS_DIR
WORKDIR $CHINADNS_DIR
RUN curl -sSL $CHINADNS_URL | tar --strip-components=1 -C $CHINADNS_DIR -xvzf -
RUN ./configure && make install
RUN mv /usr/local/bin/chinadns /usr/local/bin/


################################################################################
# Runtime
################################################################################
FROM alpine:$ALPINE_VER
RUN export DEPS=" \
    curl dnsmasq supervisor" \
    && apk add $DEPS
ADD https://github.com/zealic/autorosvpn/raw/master/chnroutes.txt /etc/chnroute.txt
ADD ./run-dns.sh /
COPY --from=source /usr/local/bin/* /usr/local/bin/

EXPOSE 53/tcp 53/udp
ENTRYPOINT ["/run.sh"]
