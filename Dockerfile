#FROM rust:1.31
#FROM alpine:3.8
FROM ubuntu:latest

ENV GRIN_NODE_VERSION=1.0.3
ENV GRIN_NODE_VERSION_TIMESTAMP=514864287

# node's data is in /data
RUN mkdir /data && mkdir /grin

# Download executable
RUN set -xe && \
  apt-get update && \
  apt-get -y install curl && \
  curl -LO https://github.com/mimblewimble/grin/releases/download/v${GRIN_NODE_VERSION}/grin-v${GRIN_NODE_VERSION}-${GRIN_NODE_VERSION_TIMESTAMP}-linux-amd64.tgz && \
  tar xzf grin-v${GRIN_NODE_VERSION}-${GRIN_NODE_VERSION_TIMESTAMP}-linux-amd64.tgz -C /grin && rm -rf grin-v${GRIN_NODE_VERSION}-${GRIN_NODE_VERSION_TIMESTAMP}-linux-amd64.tgz && \
  apt-get -y remove curl && rm -rf /var/lib/apt/lists/*

WORKDIR /data

RUN /grin/grin server config

VOLUME /data

EXPOSE 3413 3415

ENTRYPOINT ["/grin/grin"]

# forward log to docker log collector
RUN ln -sf /dev/stdout /grin/grin.log