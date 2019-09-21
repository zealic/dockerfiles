ARG ALPINE_VER=3.9
################################################################################
# Source
################################################################################
FROM golang:1-alpine AS source

RUN export DEPS=" \
    curl tar musl-dev make libtool" \
    && apk add $DEPS
ENV GOST_VER=2.8.1
ENV GOST_URL=https://github.com/ginuerzh/gost/archive/v${GOST_VER}.tar.gz
ENV GOST_DIR=/gost

RUN mkdir $GOST_DIR
WORKDIR $GOST_DIR
RUN curl -sSL $GOST_URL | tar --strip-components=1 -C $GOST_DIR -xvzf -
RUN go build -mod=vendor -o gost cmd/gost/*.go
RUN mv gost /usr/local/bin/


################################################################################
# Runtime
################################################################################
FROM alpine:$ALPINE_VER
RUN export DEPS=" \
    ca-certificates" \
    && apk add $DEPS
COPY --from=source /usr/local/bin/* /usr/local/bin/

ENTRYPOINT ["/usr/local/bin/gost"]
