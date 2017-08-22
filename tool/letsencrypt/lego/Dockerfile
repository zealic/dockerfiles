FROM zealic/alpine
MAINTAINER zealic <zealic@gmail.com>

RUN export BUILD_DEPS="go git musl-dev" \
    && export RUNTIME_DEPS="ca-certificates" \
    && set -ex \
    && apk add --update $BUILD_DEPS $RUNTIME_DEPS \
    && GOPATH=/tmp/go go get github.com/xenolf/lego \
    && mv /tmp/go/bin/lego /usr/local/bin \
    && apk del --purge $BUILD_DEPS \
    && rm -rf /tmp/* /var/cache/apk/*

ENTRYPOINT []
CMD ["/usr/local/bin/lego"]
