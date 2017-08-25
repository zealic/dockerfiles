################################################################################
# Source
################################################################################
FROM alpine:edge AS source

ENV BASE_DIR /frp

RUN apk add --update curl

ENV FRP_VERSION 0.13.0
ENV FRP_BINARY_URL https://github.com/fatedier/frp/releases/download/v${FRP_VERSION}/frp_${FRP_VERSION}_linux_amd64.tar.gz
RUN mkdir ${BASE_DIR}
RUN curl -sSL ${FRP_BINARY_URL} \
        | tar --strip-components=1 -xvzf - -C ${BASE_DIR}


################################################################################
# Runtime
################################################################################
FROM debian:stretch-slim

COPY --from=source /frp /usr/local/bin
COPY --from=source /frp/frps.ini /frps.ini

CMD ["frps", "-c", "/frps.ini"]
