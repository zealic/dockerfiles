ARG ALPINE_VER=3.10
################################################################################
# Source
################################################################################
FROM alpine:$ALPINE_VER AS source
RUN export DEPS=" \
    curl \
    git build-base linux-headers" \
    && apk add $DEPS

ENV UDP2RAW_VER=master
ENV UDP2RAW_REPO=https://github.com/wangyu-/udp2raw-tunnel.git
ENV UDP2RAW_DIR=/udp2raw
RUN mkdir $UDP2RAW_DIR
WORKDIR $UDP2RAW_DIR
RUN git init \
  && git remote add origin $UDP2RAW_REPO \
  && git fetch origin --depth 1 $UDP2RAW_VER \
  && git reset --hard FETCH_HEAD
RUN make dynamic


################################################################################
# Runtime
################################################################################
FROM alpine:$ALPINE_VER
RUN export DEPS="libstdc++ iptables" \
    && apk add $DEPS
ADD ./entrypoint.sh /
COPY --from=source /udp2raw/udp2raw_dynamic /usr/local/bin/udp2raw

ENTRYPOINT ["/entrypoint.sh"]
