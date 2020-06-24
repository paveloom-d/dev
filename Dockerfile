FROM alpine:latest

LABEL maintainer="Pavel Sobolev (https://github.com/Paveloom)"

RUN apk update && \
    apk add --no-cache zsh && \
    rm -f /tmp/* /etc/apk/cache/*

RUN sed -i -e "s/bin\/ash/bin\/zsh/" /etc/passwd

ENV SHELL /bin/zsh