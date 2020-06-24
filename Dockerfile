FROM alpine:3.12.0

LABEL maintainer="Pavel Sobolev (https://github.com/Paveloom)"

RUN apk update && \
    apk add --no-cache zsh=5.8-r1 && \
    rm -f /tmp/* /etc/apk/cache/*

RUN sed -i -e "s/bin\/ash/bin\/zsh/" /etc/passwd

ENV SHELL /bin/zsh