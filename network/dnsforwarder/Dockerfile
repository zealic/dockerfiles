FROM zealic/alpine
MAINTAINER zealic <zealic@gmail.com>

RUN export BUILD_DEPS="gcc git make automake autoconf libc-dev curl-dev" \
    && export RUNTIME_DEPS="libcurl ca-certificates" \
    && apk add --update $BUILD_DEPS $RUNTIME_DEPS \
    && git clone --depth 1 https://github.com/holmium/dnsforwarder /tmp/dnsforwarder \
    && cd /tmp/dnsforwarder \
        && ./configure && make \
    && mv /tmp/dnsforwarder/dnsforwarder /usr/local/bin \
    && apk del --purge $BUILD_DEPS \
    && rm -rf /tmp/* /var/cache/apk/*

ENTRYPOINT []
CMD ["/usr/local/bin/dnsforwarder"]
