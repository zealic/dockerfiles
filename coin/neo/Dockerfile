################################################################################
# Source
################################################################################
FROM alpine:edge AS source

ENV BASE_DIR /neo

RUN apk add --update curl

ENV NEO_VERSION 2.1.0
ENV NEO_BINARY_URL https://github.com/neo-project/neo-cli/releases/download/v${NEO_VERSION}/neo-cli-portable.zip
RUN mkdir ${BASE_DIR}
RUN curl -sSL -o /tmp/neo.zip ${NEO_BINARY_URL}
RUN ls -al /tmp && unzip /tmp/neo.zip -d /tmp && mv /tmp/neo-cli /neo


################################################################################
# Runtime
################################################################################
FROM microsoft/dotnet:1.1-runtime

RUN apt-get update && apt-get install -y libleveldb1 \
  && apt-get clean && rm -rf /var/lib/apt/lists/*

RUN cp /usr/lib/x86_64-linux-gnu/libleveldb.so.1 /usr/lib/x86_64-linux-gnu/libleveldb.so

COPY --from=source /neo/neo-cli/ /neo

VOLUME ["/Chain"]
ENTRYPOINT ["dotnet", "/neo/neo-cli.dll"]
