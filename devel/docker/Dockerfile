FROM docker/compose:1.23.2 AS source
# Docker
COPY --from=docker:18.09 /usr/local/bin/docker /usr/local/bin/
COPY --from=docker:18.09 /usr/local/bin/docker-entrypoint.sh /usr/local/bin/

FROM frolvlad/alpine-glibc
COPY --from=source /usr/local/bin/* /usr/local/bin/

RUN DEPS="make curl" \
    apk add $DEPS

ENTRYPOINT ["docker-entrypoint.sh"]
CMD ["sh"]
