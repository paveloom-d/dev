# Base image
FROM docker.io/bitnami/minideb:buster

# Meta information
LABEL maintainer="Pavel Sobolev (https://github.com/Paveloom)"
LABEL version="0.5.0"
LABEL description="This is an image containing paveloom's personal development environment."
LABEL github-repository="https://github.com/paveloom-d/dev"
LABEL image-repository="https://github.com/orgs/paveloom-d/packages/container/package/dev"

# Copy build scripts to the root
COPY build-scripts /build-scripts

# Allow their execution
RUN chmod -R +x /build-scripts

# # Temporarily disable prompts during the build
# ARG DEBIAN_FRONTEND=noninteractive

# # Set a time zone for `tzdata`
# ENV TZ=Europe/Moscow

# Install essential packages
RUN /build-scripts/root/install-essential-packages.bash

# Install Zsh
RUN /build-scripts/root/install-zsh.bash

# Set `SHELL` to Zsh
ENV SHELL /bin/zsh

# Specify new user
ENV USER=paveloom

# Set `HOME` for this user
ENV HOME /home/$USER

# Set up a new user
RUN /build-scripts/root/set-up-a-new-user.bash

# Switch to the home directory of the user
WORKDIR $HOME

# Copy user scripts
COPY user-scripts Scripts

# Allow their execution and let the user own them
RUN chown -R $USER:$USER Scripts && chmod -R +x Scripts

# Switch to the created user
USER $USER

# Point to the hosts file for SSH
RUN /build-scripts/user/point-to-the-hosts-file.bash

# Install OhMyZsh
RUN /build-scripts/user/install-ohmyzsh.bash

# Install Rust
RUN /build-scripts/user/install-rust.bash

# Install Julia
RUN /build-scripts/user/install-julia.bash

# Remove build scripts
RUN sudo rm -rf /build-scripts
