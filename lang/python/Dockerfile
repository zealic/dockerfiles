FROM zealic/alpine
MAINTAINER zealic <zealic@gmail.com>

ENV PYTHONDONTWRITEBYTECODE=x

RUN set -ex \
    && apk add --update py-pip \
    && find /usr/lib/python2.7 \( -name "*.pyc" -or -name "*.pyo" \) -type f -delete \
    && rm -rf /var/cache/apk/*

CMD ["/usr/bin/python"]
