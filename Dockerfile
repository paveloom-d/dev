# Base image
FROM alpine:3.12.0

# Meta information
LABEL maintainer="Pavel Sobolev (https://github.com/Paveloom)"

# Install Zsh
RUN apk update && \
    apk add --no-cache zsh=5.8-r1 && \
    rm -f /tmp/* /etc/apk/cache/* && \
    sed -i -e "s/bin\/ash/bin\/zsh/" /etc/passwd

# Set SHELL to Zsh
ENV SHELL /bin/zsh