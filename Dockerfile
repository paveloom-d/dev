# Note: to reduce the size and remove redundant
# layers use docker's --squash option when building

# Base image
FROM ubuntu:20.04

# Meta information
LABEL maintainer="Pavel Sobolev (https://github.com/Paveloom)"
LABEL version="0.3.3"
LABEL description="This is an image containing paveloom's personal development environment."
LABEL github-repository="https://github.com/paveloom-d/dev"
LABEL docker-repository="https://hub.docker.com/r/paveloom/dev"

# Copy docker scripts to the root
COPY docker-scripts /docker-scripts

# Allow their execution
RUN chmod -R +x /docker-scripts

# Temporarily disable prompts during the build
ARG DEBIAN_FRONTEND=noninteractive

# Set a time zone for tzdata
ENV TZ=Europe/Moscow

# Install essential packages
RUN /docker-scripts/root/essential-packages/install-essential-packages.sh

# Specify new user
ENV USER=paveloom

# Set HOME for this user
ENV HOME /home/$USER

# Set up a new user
RUN /docker-scripts/root/user/set-up-new-user.sh

# Install X2Go Server and XFCE
RUN /docker-scripts/root/x2go-server/install-x2go-server.sh

# Install the browser
RUN /docker-scripts/root/browser/install-browser.sh

# Install Zsh
RUN /docker-scripts/root/zsh/install-zsh.sh

# Set SHELL to Zsh
ENV SHELL /bin/zsh

# Install Python
RUN /docker-scripts/root/python/install-python.sh

# Temporarily disable apt-key warnings
ARG APT_KEY_DONT_WARN_ON_DANGEROUS_USAGE=1

# Install Docker
RUN /docker-scripts/root/docker/install-docker.sh

# Install Node.js and npm
RUN /docker-scripts/root/nodejs-and-npm/install-nodejs-and-npm.sh

# Install Rclone
RUN /docker-scripts/root/rclone/install-rclone.sh

# Install TexLive
RUN /docker-scripts/root/texlive/install-texlive.sh

# Install `code-server`
RUN /docker-scripts/root/code-server/install-code-server.sh

# Switch to the home directory of the user
WORKDIR $HOME

# Copy user scripts
COPY user-scripts Scripts

# Allow their execution and let the user own them
RUN chown -R $USER:$USER Scripts && chmod -R +x Scripts

# Switch to the created user
USER $USER

# Point to the hosts file for SSH
RUN /docker-scripts/user/ssh/point-to-the-hosts-file.sh

# Activate the configuration for Rclone
RUN /docker-scripts/user/rclone/touch-rclone-config.sh

# Install OhMyZsh
RUN /docker-scripts/user/ohmyzsh/install-ohmyzsh.sh

# Add ~/.local/bin to the PATH
ENV PATH=$PATH:/home/$USER/.local/bin

# Install Python packages
RUN /docker-scripts/user/python/install-python-packages.sh

# Install JupyterLab
RUN /docker-scripts/user/jupyterlab/install-jupyterlab.sh

# Add ~/Other/julia/bin to the PATH
ENV PATH=$PATH:/home/$USER/Other/julia/bin

# Install julia
RUN /docker-scripts/user/julia/install-julia.sh

# Remove docker scripts
RUN sudo rm -rf /docker-scripts