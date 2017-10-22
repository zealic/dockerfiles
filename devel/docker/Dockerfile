FROM docker:17.10 AS source

FROM docker/compose:1.16.1
COPY --from=source /usr/local/bin/* /usr/local/bin/
ENTRYPOINT ["docker-entrypoint.sh"]
CMD ["sh"]
