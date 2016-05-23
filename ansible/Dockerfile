FROM zealic/python
MAINTAINER zealic <zealic@gmail.com>

RUN export BUILD_DEPS="python-dev musl-dev openssl-dev libffi-dev gcc" \
    && export RUNTIME_DEPS="" \
    && set -ex \
    && apk add --update $BUILD_DEPS $RUNTIME_DEPS \
    && pip install --no-cache-dir ansible \
    && apk del --purge $BUILD_DEPS \
    && find /usr/lib/python2.7 \( -name "*.pyc" -or -name "*.pyo" \) -type f -delete \
    && rm -rf /var/cache/apk/*

CMD ["/usr/bin/ansible"]
