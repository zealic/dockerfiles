FROM zealic:python
MAINTAINER zealic <zealic@gmail.com>

WORKDIR /certbot
ENV PATH /certbot/venv/bin:$PATH

RUN export BUILD_DEPS="git build-base libffi-dev linux-headers openssl-dev python-dev" \
    && export RUNTIME_DEPS="dialog augeas-libs" \
    && set -ex \
    && apk add --update $BUILD_DEPS $RUNTIME_DEPS \
    && pip install --no-cache-dir virtualenv \
    && git clone --depth=1 https://github.com/certbot/certbot /certbot/src \
    && /certbot/src/letsencrypt-auto-source/letsencrypt-auto --os-packages-only \
    && virtualenv --no-site-packages -p python2 /certbot/venv \
    && /certbot/venv/bin/pip install \
                -e /certbot/src/acme \
                -e /certbot/src \
                -e /certbot/src/certbot-apache \
                -e /certbot/src/certbot-nginx \
    && find /usr/lib/python2.7 \( -name "*.pyc" -or -name "*.pyo" \) -type f -delete \
    && find /certbot/venv \( -name "*.pyc" -or -name "*.pyo" \) -type f -delete \
    && apk del --purge $BUILD_DEPS \
    && rm -rf /var/cache/apk/*

EXPOSE 80 443
VOLUME /etc/letsencrypt/

ENTRYPOINT ["certbot"]
CMD ["--help"]
