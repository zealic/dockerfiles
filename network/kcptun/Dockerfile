ARG ALPINE_VER=3.9
################################################################################
# Source
################################################################################
FROM alpine:$ALPINE_VER AS source

RUN export BUILD_DEPS="go gcc git libc-dev" \
    && export RUNTIME_DEPS="ca-certificates" \
    && apk add --update $BUILD_DEPS $RUNTIME_DEPS

RUN export GOPATH=/tmp/go \
    && export SOURCE_PATH="github.com/xtaci/kcptun" \
    && git clone --depth 1 https://$SOURCE_PATH $GOPATH/src/$SOURCE_PATH \
    && cd $GOPATH/src/$SOURCE_PATH/server \
        && go get -d && go build \
        && mv ./server /usr/local/bin/kcptun-server \
    && cd $GOPATH/src/$SOURCE_PATH/client \
    && go get -d && go build \
    && mv ./client /usr/local/bin/kcptun-client


################################################################################
# Runtime
################################################################################
FROM alpine:$ALPINE_VER

COPY --from=source /usr/local/bin/kcptun-server /usr/local/bin
COPY --from=source /usr/local/bin/kcptun-client /usr/local/bin

ENTRYPOINT ["/usr/local/bin/kcptun-server"]
CMD ["/usr/local/bin/kcptun-server"]
