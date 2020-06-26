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

# Temporarily copy scripts to the root
ADD scripts /scripts

# Allow their execution
RUN chmod -R +x /scripts

# Set up a new user
RUN /scripts/basics/set-up-new-user.sh

# Install essential packages
RUN /scripts/basics/install-essential-packages.sh

# Install Zsh and set up OhMyZsh
RUN /scripts/zsh/install-zsh-and-ohmyzsh.sh

# Set SHELL to Zsh
ENV SHELL /bin/zsh

# Remove scripts
RUN rm -rf /scripts

# Switch to the created user
USER $USER

# Switch to the home directory of this user
WORKDIR $HOME