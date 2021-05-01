# Description

### A notice

If you are unsure, please refer to the description on the last commit on the
[`master`](https://github.com/paveloom-d/dev/tree/master) branch.

### What is this?

This is an [OCI](https://opencontainers.org/) compliant image containing my personal
development environment. The main reason for creation is the desire to stop setting up
environments from scratch when transitioning between machines. Designed initially for
remote development, but can also be used both locally and in the cloud.

### What's inside?

See all details under the spoiler:

<details>
<summary>Content of the image</summary>
<ul>
  <li>Base image: <a href="https://github.com/bitnami/bitnami-docker-git">bitnami/git</a></li>
  <li>Additional essential packages:</li>
  <ul>
    <li><code>apt-utils</code></li>
    <li><code>htop</code></li>
    <li><code>ncdu</code></li>
    <li><code>zip</code></li>
    <li><code>unzip</code></li>
    <li><code>nano</code></li>
    <li><code>less</code></li>
    <li><code>wget</code></li>
    <li><code>gpg</code></li>
    <li><code>gnupg-agent</code></li>
    <li><code>keychain</code></li>
    <li><code>locales</code></li>
  </ul>
  <li>Non-root user set-up</li>
  <li><a href="#what-is-this-keychain-thing">Keychain to manage your SSH keys</a></li>
  <li><a href="#auxiliary-user-scripts-huh-whats-that">Auxiliary user scripts</a></li>
  <li>Fish as the default shell</li>
  <li><a href="#color-scheme">Color scheme</a></li>
</ul>
</details>

### How do I get it?

I recommend using [Podman](https://podman.io) for pulling and building the image or running
a container, although the same can be done using [Docker](https://www.docker.com).

Since `v0.4.0`, the image can be pulled from
[GitHub Container Registry](https://github.com/orgs/paveloom-d/packages/container/package/dev):

```bash
podman pull ghcr.io/paveloom-d/dev:tag
```

where the `tag` is one of the [releases](https://github.com/paveloom-d/dev/releases)
(e.g. `0.1.0`).

Older versions can be pulled from [DockerHub](https://hub.docker.com/r/paveloom/dev) or
from [GitHub Packages](https://github.com/paveloom-d/dev/packages/290377):

```bash
podman pull docker.io/paveloom/dev:tag
```

Since `v0.5.0` container archives are provided as part of the
[releases](https://github.com/paveloom-d/dev/releases). These can be used for importing a
container using Docker / Podman or for registering as a WSL distribution.

### Can I build the image myself?

Yes. To build the image, checkout the repository from a tagged commit on the `master` branch
and execute the following in the repository's root directory:

```bash
podman build --squash-all -t dev .
```

You can then run a container based on this image as follows:

```bash
podman run --name container -t -d dev
```

Since Fish is the default shell, you can enter the container using the following command:

```bash
podman exec -it container fish
```

### I don't see any password requests. Is that normal?

Yes. The system will not ask the user to enter a password (this makes it
easier to run administrator commands, for instance), but it will be asked if you try to
establish an [SSH connection](#so-i-can-connect-to-this-container-over-ssh) with a
container from the outside. If no password has been set, the connection cannot be
established. If you want to set this password, run `passwd $USER` as root.

### So I can connect to a container over SSH?

Absolutely. Although to establish an SSH connection to the container, you need to map the
container's `22` port to any other port available and not occupied on the host machine
(for example, `5001`).

This can be accomplished by running a container using the `-p` flag:

```bash
podman run -p 5001:22 --name container -t -d dev
```

Remember, you can't publish new ports when the container is already running.

If the SSH service is running inside the container (it starts automatically when you
open a new shell instance, although you can check this by running `service ssh status`),
you can SSH into the container as follows:

```bash
ssh -p 5001 username@remote
```

This will prompt for the `username`'s password. If you haven't done this yet,
[set it up](#i-dont-see-any-password-requests-is-that-normal).

### What is this Keychain thing?

Instead of calling `ssh-add` every time you log-in, you can add your SSH key(s) using
[`keychain`](https://linux.die.net/man/1/keychain). The corresponding lines are present
in the `~/.config/fish/config.fish`, just uncomment them and specify your keys.

### Auxiliary user scripts, huh? What's that?

The image provides auxiliary scripts that can help the user create SSH and GPG keys and
connect them to an account on GitHub. These scripts adjust Git config and add several
Git aliases.

Also, scripts to install the latest stable versions of Julia and Rust are included.

They are located in `~/Scripts`.

### Color scheme?

Different terminals (like Xterm), programs (like Visual Studio Code) and utilities
(like PuTTY) have their own color pallettes. So the current theme can look ugly depending
on what you use to enter the container. Since this is my image, I made it look more or less
attractive when using [Windows Terminal](https://github.com/microsoft/terminal) with the
following scheme:

```json
{
  "name": "paveloom-theme",
  "black": "#fefefe",
  "red": "#f97e72",
  "green": "#72f1b8",
  "yellow": "#fede5d",
  "blue": "#f772e0",
  "purple": "#c792ea",
  "cyan": "#f772e0",
  "white": "#f92aad",
  "brightBlack": "#f772e0",
  "brightRed": "#f88414",
  "brightGreen": "#72f1b8",
  "brightYellow": "#fff951",
  "brightBlue": "#36f9f6",
  "brightPurple": "#c792ea",
  "brightCyan": "#f92aad",
  "brightWhite": "#fefefe",
  "background": "#2a2139",
  "foreground": "#f0eff1"
}
```

It's based on
[`synthwave-everything`](https://atomcorp.github.io/themes/?theme=synthwave-everything).
With everything else set correctly, the terminal window should look like this:

![](https://github.com/paveloom-d/dev/raw/master/.github/pictures/color-theme.png)
