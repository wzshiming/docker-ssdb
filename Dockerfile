FROM alpine:${ALPINE_VERSION:-3.7}

LABEL maintainer="wzshiming@foxmail.com"

ARG SSDB_VERSION=${VERSION:-1.8.2}

RUN apk add -U --no-cache --virtual .build-deps \
      curl gcc g++ make autoconf libc-dev libevent-dev linux-headers perl tar \
    && mkdir -p /ssdb/tmp \
    && curl -Lk "https://github.com/ideawu/ssdb/archive/${SSDB_VERSION}.tar.gz" | \
       tar -xz -C /ssdb/tmp --strip-components=1 \
    && cd /ssdb/tmp \
    && make -j$(getconf _NPROCESSORS_ONLN) \
    && make install PREFIX=/ssdb \
    && rm -rf /ssdb/tmp \
    && apk add --virtual .rundeps libstdc++ \
    && apk del .build-deps

COPY entrypoint.sh /usr/local/bin/

EXPOSE 8888
VOLUME /ssdb/var

CMD entrypoint.sh