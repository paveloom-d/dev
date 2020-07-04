# Note: to reduce the size and remove redundant
# layers use docker's --squash option when building

# Base image
FROM ubuntu:20.04

# Meta information
LABEL maintainer="Pavel Sobolev (https://github.com/Paveloom)"
LABEL version="0.3.0"
LABEL description="This is an image containing paveloom's personal development environment."
LABEL github-repository="https://github.com/paveloom-d/dev"
LABEL docker-repository="https://hub.docker.com/r/paveloom/dev"

# Temporarily copy scripts to the root
COPY scripts /scripts

# Allow their execution and let user own them
RUN chmod -R +x /scripts

# Temporarily disable prompts during the build
ARG DEBIAN_FRONTEND=noninteractive

# Set a time zone for tzdata
ENV TZ=Europe/Moscow

# Install essential packages
RUN /scripts/root/essential-packages/install-essential-packages.sh

# Specify new user
ENV USER=paveloom

# Set HOME for this user
ENV HOME /home/$USER

# Set up a new user
RUN /scripts/root/user/set-up-new-user.sh

# Install Zsh
RUN /scripts/root/zsh/install-zsh.sh

# Set SHELL to Zsh
ENV SHELL /bin/zsh

# Install Python
RUN /scripts/root/python/install-python.sh

# Temporarily disable apt-key warnings
ARG APT_KEY_DONT_WARN_ON_DANGEROUS_USAGE=1

# Install Docker
RUN /scripts/root/docker/install-docker.sh

# Install Node.js and npm
RUN /scripts/root/nodejs-and-npm/install-nodejs-and-npm.sh

# Install TexLive
RUN /scripts/root/texlive/install-texlive.sh

# Switch to the created user
USER $USER

# Switch to the home directory of this user
WORKDIR $HOME

# Install OhMyZsh
RUN /scripts/user/ohmyzsh/install-ohmyzsh.sh

# Add ~/.local/bin to the PATH
ENV PATH=$PATH:/home/$USER/.local/bin

# Install Python packages
RUN /scripts/user/python/install-python-packages.sh

# Install JupyterLab
RUN /scripts/user/jupyterlab/install-jupyterlab.sh

# Add ~/Other/julia/bin to the PATH
ENV PATH=$PATH:/home/$USER/Other/julia/bin

# Install julia
RUN /scripts/user/julia/install-julia.sh

# Remove scripts
RUN sudo rm -rf /scripts

# Set DEBIAN_FRONTEND to teletype
ENV DEBIAN_FRONTEND=teletype