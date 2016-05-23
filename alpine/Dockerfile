FROM alpine:edge
MAINTAINER zealic <zealic@gmail.com>

RUN export ALPINE_VERSION=edge \
  && export ALPINE_MIRROR_HOST=mirrors.tuna.tsinghua.edu.cn \
  && echo "https://$ALPINE_MIRROR_HOST/alpine/$ALPINE_VERSION/main/" > /etc/apk/repositories \
  && echo "https://$ALPINE_MIRROR_HOST/alpine/$ALPINE_VERSION/community/" >> /etc/apk/repositories

RUN set -ex \
    && apk upgrade --update \
    && rm -rf /var/cache/apk/*
