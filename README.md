# Description

### A notice

If you are unsure, please refer to the description on the last commit on the
[`master`](https://github.com/paveloom-d/dev/tree/master) branch.

### Development

There is a [ZenHub](https://www.zenhub.com/) board, so if you want to see it, make sure you
have the extension installed.

### Content of the image

- Image version: 0.3.3
- Base image: Ubuntu (20.04)
- Essential packages:
    - apt-utils
    - apt-transport-https
    - dialog
    - dumb-init
    - htop
    - ca-certificates
    - git
    - make
    - ncdu
    - zip
    - unzip
    - nano
    - less
    - wget
    - curl
    - gnupg-agent
    - sudo (1.9.1)
    - ssh
    - locales
    - software-properties-common
- Non-root user set-up
- [Keychain to manage your SSH keys](#keychain)
- X2Go Server and XFCE DE
- Midori Web Browser
- [Auxiliary user scripts](#users-scripts)
- Zsh as the default shell:
    - [OhMyZsh](https://github.com/ohmyzsh/ohmyzsh):
        - Additional plugins:
            - [Zsh-autosuggestions](https://github.com/zsh-users/zsh-autosuggestions)
        - [Theme adjustments](#color-theme)
- Docker
- Python:
    - python3-dev
    - python3-pip
    - Packages:
        - wheel
        - numpy
        - matplotlib
- Jupyter:
    - jupyter
    - jupyterlab
    - [Aliases to run a notebook server](#jupyter)
- Julia (1.5.0):
    - [Documenter.jl](https://github.com/JuliaDocs/Documenter.jl)
    - [Literate.jl](https://github.com/fredrikekre/Literate.jl)
    - [Revise.jl](https://github.com/timholy/Revise.jl)
    - [IJulia.jl](https://github.com/JuliaLang/IJulia.jl/)
    - [PyPlot.jl](https://github.com/JuliaPy/PyPlot.jl)
    - [Plots.jl](https://github.com/JuliaPlots/Plots.jl)
- Node.js and npm
- Rclone
- TexLive:
    - dvipng
    - texlive-latex-extra
    - texlive-fonts-extra
    - texlive-lang-cyrillic
    - cm-super
- [`code-server`](#code-server)

### Download

This image can be pulled from [Docker Hub](https://hub.docker.com/r/paveloom/dev):

```bash
docker pull paveloom/dev:0.3.3
```

or from [GitHub Packages](https://github.com/paveloom-d/dev/packages):

```bash
docker pull docker.pkg.github.com/paveloom-d/dev/dev:0.3.3
```

After that, you can run a container based on that image. If you want to build the image
yourself, see the next section.

### Build, run, and enter

There is nothing special when building, although I would recommend squashing the image.
By this means using the Docker's `--squash` flag, which is an experimental feature.
To enable it, make sure you have the following code in the `/etc/docker/daemon.json` file:

```json
{
    "experimental": true
}
```

To build the image, execute the following in the root directory:

```bash
docker build -t image --squash .
```

You can then run the container as follows:

```bash
docker run --name container -t -d image
```

Since Zsh is the default shell, you can enter the container using the following command:

```bash
docker exec -it container zsh
```

### Using Docker inside

Bind mounting the Docker socket allows you to develop other images inside a running
container. This requires that the `others` group has read and write privileges relative
to your local socket. You can give these privileges as follows:

```bash
sudo chmod o+rw /var/run/docker.sock
```

After that, the container should be run with an additional `-v` flag:

```bash
docker run -v /var/run/docker.sock:/var/run/docker.sock --name container -t -d image
```

### Jupyter

To use Jupyter Notebook or Jupyter Lab you will need to do two things.

First, publish the `8888` port (or any other, but this one is standard) when running a
container:

```bash
docker run -p 8888:8888 --name container -t -d image
```

Secondly, while inside the container, run the notebook server listening on IP `0.0.0.0`:

```bash
jupyter notebook --ip 0.0.0.0 --no-browser
```

There are handy aliases for the last step: `jnote` for Jupyter Notebook and `jlab` for
Jupyter Lab.

### User's password

The system (by default) will not ask the user to enter a password (this makes it easier to
run administrator commands), but this password exists and will be asked when you try to
establish an [SSH connection](#ssh) with a container from the outside. If you want to set
this password, run `passwd $USER` as root.

### SSH

To establish an SSH connection to the container, you need to map the container's `22` port
to any other port available and not occupied on the host machine (for example, `5001`).

This can be accomplished by running the container using the `-p` flag:

```bash
docker run -p 5001:22 --name container -t -d image
```

Remember, you can't publish new ports when the container is already running.

If the SSH service is running inside the container (it starts automatically when you
open a new shell instance, however, you can check this by doing `service ssh status`),
you can SSH into the container as follows:

```bash
ssh -p 5001 username@remote
```

This will prompt for the `username`'s password. If you haven't done this yet,
[set it up](#users-password).

### Keychain

Instead of calling `ssh-add` every time, you can add your SSH key(s) using `keychain`.
The corresponding lines are present in the `~/.zshrc`, just uncomment them and specify
your keys.

### User's scripts

The image provides auxiliary scripts that can help the user create SSH and GPG keys and
connect them to an account on GitHub. They are located in `~/Scripts`.

### Key bindings

This image provides keyboard shortcuts to delete a word before and after the cursor:
<kbd>Ctrl+Backspace</kbd> and <kbd>Ctrl+Delete</kbd> respectively. However, if you are
using [Windows Terminal](https://github.com/microsoft/terminal), you may find that the
first one does not work when you use an SSH connection. This has been discussed
[here](https://github.com/microsoft/terminal/issues/755),
and one of the solutions that you can use is this [AutoHotkey](https://www.autohotkey.com/)
script:

```autohotkey
; For Windows Terminal: deletes the previous word
#IfWinActive ahk_exe WindowsTerminal.exe ; Only apply when this window is active
^backspace::
    Send, ^H
return
#IfWinActive ; Turn off context sensitivity
```

### Code Server

This image contains the [`code-server`](https://github.com/cdr/code-server):
[Visual Studio Code](https://code.visualstudio.com/) fork to run IDE in the browser.
By default, it uses port `8080`, so this port must be published before running the
container:

```bash
docker run -p 8080:8080 --name container -t -d image
```

### Color theme

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
[`synthwave-everything`](https://atomcorp.github.io/themes/?theme=synthwave-everything),
which I believe was intended for local development. I made a few changes to make it
suitable for remote development. With everything else set correctly, the terminal window
should look like this:

![](https://github.com/paveloom-d/dev/raw/master/.github/pictures/color-theme.png)
