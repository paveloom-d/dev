# Note: to reduce the size and remove redundant
# layers use docker's --squash option when building

# Base image
FROM alpine:3.12.0

# Meta information
LABEL maintainer="Pavel Sobolev (https://github.com/Paveloom)"
LABEL version="0.1.0"
LABEL description="This is paveloom's dev image."

# Install debugging packages
RUN apk update && \
    # Install git
    apk add --no-cache git=2.26.2-r0 \
    # Install nano
    nano=4.9.3-r0

# Install Zsh and set up OhMyZsh
RUN apk update && \
    # Install the package
    apk add --no-cache zsh=5.8-r1 && \
    # Change default shell
    sed -i -e "s/bin\/ash/bin\/zsh/" /etc/passwd && \
    # Install OhMyZsh
    sh -c "$(wget -O- https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" && \
    # Download zsh-autosuggestions plugin
    git clone https://github.com/zsh-users/zsh-autosuggestions "${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions" && \
    # Activate the plugin
    sed -i '/plugins=(git)/c\plugins=(git zsh-autosuggestions)' ~/.zshrc

# Set SHELL to Zsh
ENV SHELL /bin/zsh