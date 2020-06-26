# Note: to reduce the size and remove redundant
# layers use docker's --squash option when building

# Base image
FROM alpine:3.12.0

# Meta information
LABEL maintainer="Pavel Sobolev (https://github.com/Paveloom)"
LABEL version="0.1.0"
LABEL description="This is paveloom's dev image."

# Specify new user
ENV USER=paveloom

# Set HOME for this user
ENV HOME /home/$USER

# Set up a new user
RUN \
    # Install sudo
    apk add --no-cache sudo=1.9.0-r0 && \
    # Create a new user
    adduser -D $USER && \
    # Disable password prompt
    echo "$USER ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/$USER && \
    # Set read only mode for this file
    chmod 0440 /etc/sudoers.d/$USER

# Install essential packages
RUN \
    # Install git
    apk add --no-cache git=2.26.2-r0 \
    # Install nano
    nano=4.9.3-r0

# Install Zsh and set up OhMyZsh
RUN \
    # Install the package
    apk add --no-cache zsh=5.8-r1 && \
    # Change default shell
    sed -i -e "s/bin\/ash/bin\/zsh/" /etc/passwd && \
    # Install OhMyZsh
    sh -c "$(wget -O- https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" && \
    # Download zsh-autosuggestions plugin
    git clone https://github.com/zsh-users/zsh-autosuggestions ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions && \
    # Activate the plugin
    sed -i '/plugins=(git)/c\plugins=(git zsh-autosuggestions)' ~/.zshrc && \
    # # Activate zshcfg alias
    sed -i '/# alias zshconfig="mate ~\/\.zshrc"/c\alias zshcfg="nano ~\/\.zshrc"' ~/.zshrc

# Set SHELL to Zsh
ENV SHELL /bin/zsh

# Switch to the created user
USER $USER

# Switch to the home directory of this user
WORKDIR $HOME