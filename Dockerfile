# Base image
FROM docker.io/library/ubuntu:20.10

# Meta information
LABEL maintainer="Pavel Sobolev (https://github.com/Paveloom)"
LABEL version="0.4.0"
LABEL description="This is an image containing paveloom's personal development environment."
LABEL github-repository="https://github.com/paveloom-d/dev"
LABEL image-repository="https://hub.docker.com/r/paveloom/dev"

# Copy build scripts to the root
COPY build-scripts /build-scripts

# Allow their execution
RUN chmod -R +x /build-scripts

# Temporarily disable prompts during the build
ARG DEBIAN_FRONTEND=noninteractive

# Set a time zone for `tzdata`
ENV TZ=Europe/Moscow

# Install essential packages
RUN /build-scripts/root/install-essential-packages.sh

# Specify new user
ENV USER=paveloom

# Set `HOME` for this user
ENV HOME /home/$USER

# Set up a new user
RUN /build-scripts/root/set-up-a-new-user.sh

# Install X2Go Server and XFCE
RUN /build-scripts/root/install-x2go-and-xfce.sh

# Install a browser
RUN /build-scripts/root/install-browser.sh

# Install Zsh
RUN /build-scripts/root/install-zsh.sh

# Set `SHELL` to Zsh
ENV SHELL /bin/zsh

# Install Python
RUN /build-scripts/root/install-python.sh

# Temporarily disable `apt-key` warnings
ARG APT_KEY_DONT_WARN_ON_DANGEROUS_USAGE=1

# Install Podman and Buildah
RUN /build-scripts/root/install-podman-and-buildah.sh

# Install Node.js and npm
RUN /build-scripts/root/install-nodejs-and-npm.sh

# Install Rclone
RUN /build-scripts/root/install-rclone.sh

# Install TexLive
RUN /build-scripts/root/install-texlive.sh

# Switch to the home directory of the user
WORKDIR $HOME

# Copy user scripts
COPY user-scripts Scripts

# Allow their execution and let the user own them
RUN chown -R $USER:$USER Scripts && chmod -R +x Scripts

# Switch to the created user
USER $USER

# Point to the hosts file for SSH
RUN /build-scripts/user/point-to-the-hosts-file.sh

# Activate the configuration for Rclone
RUN /build-scripts/user/touch-rclone-config.sh

# Install OhMyZsh
RUN /build-scripts/user/install-ohmyzsh.sh

# Add `~/.local/bin` to the `PATH`
ENV PATH=$PATH:/home/$USER/.local/bin

# Install Python packages
RUN /build-scripts/user/install-python-packages.sh

# Install Jupyter
RUN /build-scripts/user/install-jupyter.sh

# Add `~/.cargo/bin` to the `PATH`
ENV PATH=$PATH:/home/$USER/.cargo/bin

# Install Rust
RUN /build-scripts/user/install-rust.sh

# Add `~/Other/julia/bin` to the `PATH`
ENV PATH=$PATH:/home/$USER/Other/julia/bin

# Install Julia
RUN /build-scripts/user/install-julia.sh

# Remove build scripts
RUN sudo rm -rf /build-scripts
