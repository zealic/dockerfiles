ARG ALPINE_VER=3.9
FROM alpine:${ALPINE_VER} as source
ENV S3FS_VERSION=1.84
RUN export BUILD_DEPS="build-base libtool automake \
       autoconf fuse-dev curl-dev libxml2-dev curl libressl-dev" \
    && apk add --update $BUILD_DEPS $RUNTIME_DEPS
RUN curl -L https://github.com/s3fs-fuse/s3fs-fuse/archive/v$S3FS_VERSION.tar.gz | tar zxv -C /tmp \
    && cd /tmp/s3fs-fuse-* \
      && ./autogen.sh && ./configure --prefix=/usr/local && make && make install

FROM alpine:${ALPINE_VER}
RUN apk add fuse libstdc++ libxml2 libcurl libcap libressl
COPY --from=source /usr/local/bin/s3fs /usr/local/bin/
ADD ./entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
CMD ["/usr/local/bin/s3fs"]
