ARG DOCKER_VER=18.09
ARG COMPOSE_VER=1.23.2
ARG ALPINE_VER=3.9
FROM docker:${DOCKER_VER} AS source-docker
FROM docker/compose:${COMPOSE_VER} AS source
# Docker
COPY --from=source-docker /usr/local/bin/docker /usr/local/bin/
COPY --from=source-docker /usr/local/bin/docker-entrypoint.sh /usr/local/bin/

FROM frolvlad/alpine-glibc:alpine-${ALPINE_VER}
COPY --from=source /usr/local/bin/* /usr/local/bin/

RUN DEPS="make curl" \
    apk add $DEPS

ENTRYPOINT ["docker-entrypoint.sh"]
CMD ["sh"]
