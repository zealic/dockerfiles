FROM zealic/python
MAINTAINER zealic <zealic@gmail.com>

RUN export BUILD_DEPS="" \
    && export RUNTIME_DEPS="groff less" \
    && set -ex \
    && apk add --update $BUILD_DEPS $RUNTIME_DEPS \
    && pip install --no-cache-dir awscli \
    && find /usr/lib/python2.7 \( -name "*.pyc" -or -name "*.pyo" \) -type f -delete \
    && apk del --purge $BUILD_DEPS \
    && rm -rf /var/cache/apk/*

ENTRYPOINT ["/usr/bin/aws"]
CMD ["help"]
