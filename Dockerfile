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

# # Install Zsh
# RUN /build-scripts/root/install-zsh.bash

# # Set `SHELL` to Zsh
# ENV SHELL /bin/zsh

# # Specify new user
# ENV USER=paveloom

# # Set `HOME` for this user
# ENV HOME /home/$USER

# # Set up a new user
# RUN /build-scripts/root/set-up-a-new-user.bash

# # Install X2Go Server and XFCE
# RUN /build-scripts/root/install-x2go-and-xfce.bash

# # Install a browser
# RUN /build-scripts/root/install-browser.bash

# # Install Python
# RUN /build-scripts/root/install-python.bash

# # Temporarily disable `apt-key` warnings
# ARG APT_KEY_DONT_WARN_ON_DANGEROUS_USAGE=1

# # Install Podman and Buildah
# RUN /build-scripts/root/install-podman-and-buildah.bash

# # Install Node.js and npm
# RUN /build-scripts/root/install-nodejs-and-npm.bash

# # Install Rclone
# RUN /build-scripts/root/install-rclone.bash

# # Install TexLive
# RUN /build-scripts/root/install-texlive.bash

# # Switch to the home directory of the user
# WORKDIR $HOME

# # Copy user scripts
# COPY user-scripts Scripts

# # Allow their execution and let the user own them
# RUN chown -R $USER:$USER Scripts && chmod -R +x Scripts

# # Switch to the created user
# USER $USER

# # Point to the hosts file for SSH
# RUN /build-scripts/user/point-to-the-hosts-file.bash

# # Activate the configuration for Rclone
# RUN /build-scripts/user/touch-rclone-config.bash

# # Install OhMyZsh
# RUN /build-scripts/user/install-ohmyzsh.bash

# # Add `~/.local/bin` to the `PATH`
# ENV PATH=$PATH:/home/$USER/.local/bin

# # Install Python packages
# RUN /build-scripts/user/install-python-packages.bash

# # Install Jupyter
# RUN /build-scripts/user/install-jupyter.bash

# # Add `~/.cargo/bin` to the `PATH`
# ENV PATH=$PATH:/home/$USER/.cargo/bin

# # Install Rust
# RUN /build-scripts/user/install-rust.bash

# # Add `~/Other/julia/bin` to the `PATH`
# ENV PATH=$PATH:/home/$USER/Other/julia/bin

# # Install Julia
# RUN /build-scripts/user/install-julia.bash

# # Remove build scripts
# RUN sudo rm -rf /build-scripts
