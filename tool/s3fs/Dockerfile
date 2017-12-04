FROM alpine:edge
LABEL maintainer zealic <zealic@gmail.com>

RUN export ALPINE_VERSION=edge \
  && export ALPINE_MIRROR_HOST=mirrors.tuna.tsinghua.edu.cn \
  && echo "https://$ALPINE_MIRROR_HOST/alpine/$ALPINE_VERSION/main/" > /etc/apk/repositories \
  && echo "https://$ALPINE_MIRROR_HOST/alpine/$ALPINE_VERSION/community/" >> /etc/apk/repositories

RUN export S3FS_VERSION=1.82 \
    && export BUILD_DEPS="build-base libtool automake \
       autoconf fuse-dev curl-dev libxml2-dev curl libressl-dev" \
    && export RUNTIME_DEPS="fuse libstdc++ libxml2 libcurl libcap libressl" \
    && set -ex \
    && apk add --update $BUILD_DEPS $RUNTIME_DEPS \
    && curl -L https://github.com/s3fs-fuse/s3fs-fuse/archive/v$S3FS_VERSION.tar.gz | tar zxv -C /tmp \
    && cd /tmp/s3fs-fuse-* \
      && ./autogen.sh && ./configure --prefix=/usr && make && make install \
    && apk del --purge $BUILD_DEPS \
    && rm -rf /var/cache/apk/*

ADD ./entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]

CMD ["/usr/bin/s3fs"]
