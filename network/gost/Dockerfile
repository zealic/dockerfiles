FROM zealic/alpine
MAINTAINER zealic <zealic@gmail.com>

RUN export BUILD_DEPS="go gcc git libc-dev" \
    && export RUNTIME_DEPS="ca-certificates" \
    && apk add --update $BUILD_DEPS $RUNTIME_DEPS \
    && export GOPATH=/tmp/go \
    && git clone --depth 1 https://github.com/ginuerzh/gost $GOPATH/src/github.com/ginuerzh/gost \
    && cd $GOPATH/src/github.com/ginuerzh/gost \
        && go get -d && go install \
    && mv /tmp/go/bin/gost /usr/local/bin \
    && apk del --purge $BUILD_DEPS \
    && rm -rf /tmp/* /var/cache/apk/*

ENTRYPOINT []
CMD ["/usr/local/bin/gost"]

