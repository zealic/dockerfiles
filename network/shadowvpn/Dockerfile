ARG ALPINE_VER=3.9
################################################################################
# Source
################################################################################
FROM alpine:$ALPINE_VER AS source
ENV SHADOWVPN_VER=master
ENV SHADOWVPN_REPO=https://github.com/WeShadowsocks/ShadowVPN.git
RUN export DEPS=" \
    autoconf automake build-base gawk git libtool linux-headers" \
    && apk add $DEPS
ENV SHADOWVPN_DIR=/shadowvpn
RUN mkdir $SHADOWVPN_DIR
WORKDIR $SHADOWVPN_DIR
RUN git init \
  && git remote add origin $SHADOWVPN_REPO \
  && git fetch origin --depth 1 $SHADOWVPN_VER \
  && git reset --hard FETCH_HEAD
RUN git submodule update --init --recursive
RUN ./autogen.sh
RUN ./configure --enable-static --sysconfdir=/etc
RUN make install


################################################################################
# Runtime
################################################################################
FROM alpine:$ALPINE_VER
RUN export DEPS="iptables" \
    && apk add $DEPS
ADD ./entrypoint.sh /
COPY --from=source /usr/local/bin/* /usr/local/bin/
COPY --from=source /etc/shadowvpn/* /etc/shadowvpn/

EXPOSE 1123/udp
ENTRYPOINT ["/entrypoint.sh"]
