# Base image
FROM alpine:3.12.0

# Meta information
LABEL maintainer="Pavel Sobolev (https://github.com/Paveloom)"
LABEL version="0.1.0"
LABEL description="This is paveloom's dev image."

# Install Zsh
RUN apk update && \
    # Install the package
    apk add --no-cache zsh=5.8-r1 && \
    # Remove cache
    rm -f /tmp/* /etc/apk/cache/* && \
    # Change default shell
    sed -i -e "s/bin\/ash/bin\/zsh/" /etc/passwd

# Set SHELL to Zsh
ENV SHELL /bin/zsh