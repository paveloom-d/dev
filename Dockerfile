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
RUN /build-scripts/root/essential-packages/install-essential-packages.sh

# Specify new user
ENV USER=paveloom

# Set `HOME` for this user
ENV HOME /home/$USER

# Set up a new user
RUN /build-scripts/root/user/set-up-new-user.sh

# Install X2Go Server and XFCE
RUN /build-scripts/root/x2go-server/install-x2go-server.sh

# Install the browser
RUN /build-scripts/root/browser/install-browser.sh

# Install Zsh
RUN /build-scripts/root/zsh/install-zsh.sh

# Set `SHELL` to Zsh
ENV SHELL /bin/zsh

# Install Python
RUN /build-scripts/root/python/install-python.sh

# Temporarily disable `apt-key` warnings
ARG APT_KEY_DONT_WARN_ON_DANGEROUS_USAGE=1

# Install Podman and Buildah
RUN /build-scripts/root/podman-and-buildah/install-podman-and-buildah.sh

# Install Node.js and npm
RUN /build-scripts/root/nodejs-and-npm/install-nodejs-and-npm.sh

# Install Rclone
RUN /build-scripts/root/rclone/install-rclone.sh

# Install TexLive
RUN /build-scripts/root/texlive/install-texlive.sh

# Switch to the home directory of the user
WORKDIR $HOME

# Copy user scripts
COPY user-scripts Scripts

# Allow their execution and let the user own them
RUN chown -R $USER:$USER Scripts && chmod -R +x Scripts

# Switch to the created user
USER $USER

# Point to the hosts file for SSH
RUN /build-scripts/user/ssh/point-to-the-hosts-file.sh

# Activate the configuration for Rclone
RUN /build-scripts/user/rclone/touch-rclone-config.sh

# Install OhMyZsh
RUN /build-scripts/user/ohmyzsh/install-ohmyzsh.sh

# Add `~/.local/bin` to the `PATH`
ENV PATH=$PATH:/home/$USER/.local/bin

# Install Python packages
RUN /build-scripts/user/python/install-python-packages.sh

# Install JupyterLab
RUN /build-scripts/user/jupyterlab/install-jupyterlab.sh

# Add `~/Other/julia/bin` to the `PATH`
ENV PATH=$PATH:/home/$USER/Other/julia/bin

# Install Julia
RUN /build-scripts/user/julia/install-julia.sh

# Remove build scripts
RUN sudo rm -rf /build-scripts
