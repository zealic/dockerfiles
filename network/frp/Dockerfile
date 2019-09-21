ARG ALPINE_VER=3.9
################################################################################
# Source
################################################################################
FROM alpine:${ALPINE_VER} AS source

ENV BASE_DIR /frp

RUN apk add --update curl

ENV FRP_VER=0.29.0
ENV FRP_URL=https://github.com/fatedier/frp/releases/download/v${FRP_VER}/frp_${FRP_VER}_linux_amd64.tar.gz
RUN mkdir ${BASE_DIR}
RUN curl -sSL ${FRP_URL} \
        | tar --strip-components=1 -xvzf - -C ${BASE_DIR}


################################################################################
# Runtime
################################################################################
FROM debian:stretch-slim

COPY --from=source /frp /usr/local/bin
ADD ./entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
