FROM alpine:edge
MAINTAINER zealic <zealic@gmail.com>

RUN export ALPINE_VERSION=edge \
  && export ALPINE_MIRROR_HOST=mirrors.tuna.tsinghua.edu.cn \
  && echo "https://$ALPINE_MIRROR_HOST/alpine/$ALPINE_VERSION/main/" > /etc/apk/repositories \
  && echo "https://$ALPINE_MIRROR_HOST/alpine/$ALPINE_VERSION/community/" >> /etc/apk/repositories

ENV PYTHONDONTWRITEBYTECODE=x

RUN set -ex \
    && apk add --update py-pip \
    && find /usr/lib/python2.7 \( -name "*.pyc" -or -name "*.pyo" \) -type f -delete \
    && rm -rf /var/cache/apk/*

CMD ["/usr/bin/python"]
