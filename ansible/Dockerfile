FROM alpine:3.3
MAINTAINER zealic <zealic@gmail.com>

RUN export ALPINE_VERSION=3.3 && export ALPINE_MIRROR_HOST=mirrors.tuna.tsinghua.edu.cn \
  && echo "https://$ALPINE_MIRROR_HOST/alpine/v$ALPINE_VERSION/main/" > /etc/apk/repositories \
  && echo "https://$ALPINE_MIRROR_HOST/alpine/edge/community/" >> /etc/apk/repositories

ENV PYTHONDONTWRITEBYTECODE=x

RUN export BUILD_DEPS="python-dev musl-dev openssl-dev libffi-dev gcc" \
    && export RUNTIME_DEPS="py-pip" \
    && set -ex \
    && apk add --update $BUILD_DEPS $RUNTIME_DEPS \
    && pip install --no-cache-dir --upgrade pip \
    && pip install --no-cache-dir ansible \
    && apk del --purge $BUILD_DEPS \
    && find /usr/lib/python2.7 \( -name "*.pyc" -or -name "*.pyo" \) -type f -delete \
    && rm -rf /var/cache/apk/*

CMD ["/usr/bin/ansible"]
