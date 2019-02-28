FROM docker:18.09 AS source

FROM docker/compose:1.23.2
COPY --from=source /usr/local/bin/* /usr/local/bin/
RUN DEPS="make curl" \
    apk add $DEPS

ENTRYPOINT ["docker-entrypoint.sh"]
CMD ["sh"]
