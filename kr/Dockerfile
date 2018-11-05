ARG BUILD_FROM
FROM $BUILD_FROM

ENV LANG C.UTF-8

WORKDIR /root


ARG BUILD_ARCH
ARG KRGO_VERSION="0.1.0"
ARG KRGO_ARCH="x86_64"

RUN apk update \
    && apk add --no-cache nodejs-current jq curl wget

RUN set -x \
    && if [ $BUILD_ARCH == "armhf" ]; then FRP_ARCH="arm"; fi \
    && if [ $BUILD_ARCH == "amd64" ]; then FRP_ARCH="x86_64"; fi \
    && if [ $BUILD_ARCH == "i386" ]; then FRP_ARCH="i386"; fi \
    && if [ $BUILD_ARCH == "aarch64" ]; then FRP_ARCH="aarch64"; fi \
    && URL_VERSION="https://raw.githubusercontent.com/jimusio/bridge/master/version.json" \
    && KRGO_VERSION=$(curl -s $URL_VERSION | jq -e -r '.krgo') \
    && wget https://github.com/jimusio/bridge/raw/master/data/go/kr-Linux-${KRGO_ARCH}-${KRGO_VERSION} \
    && mv kr-Linux-${KRGO_ARCH}-${KRGO_VERSION} kr \
    && chmod a+x kr

ADD run.sh /root
RUN chmod a+x /root/run.sh

CMD [ "/root/run.sh" ]
