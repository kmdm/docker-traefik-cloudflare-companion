FROM kmdm/alpine:3.13
LABEL maintainer="Dave Conroy (dave at tiredofit dot ca)"

### Set Environment Variables
ENV ENABLE_CRON=false \
    ENABLE_SMTP=false

### Dependencies
RUN set -x && \
    apk update && \
    apk upgrade && \
    apk add -t .tcc-build-deps \
                gcc \
                libffi-dev \
                musl-dev \
                openssl-dev \
                py-pip \
                py3-setuptools \
                py3-wheel \
                python3-dev \
                && \
    \
    apk add -t .tcc-run-deps \
                py3-beautifulsoup4 \
                py3-certifi \
                py3-chardet \
                py3-cryptography \
                py3-idna \
                py3-openssl \
                py3-requests \
                py3-soupsieve \
                py3-urllib3 \
                py3-websocket-client \
                py3-yaml \
                python3 \
                && \
    \
    pip install \
            cloudflare \
            get-docker-secret \
            docker[tls] \
            && \
    \
### Cleanup
    apk del .tcc-build-deps && \
    rm -rf /root/.cache && \
    rm -rf /var/cache/apk/*

### Add Files
ADD install /
