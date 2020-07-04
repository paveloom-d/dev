# Description

### A notice

If you are not sure, please, follow only the instructions linked to [the last tagged version of the image](https://github.com/paveloom-d/dev/packages/290377/versions). The development happens in-place, so the description you see on the [landing page](https://github.com/paveloom-d/dev) may differ drastically and not be usable for the released versions yet.

### Contents

- Image version: 0.3.0
- Base image: Ubuntu (20.04)
- Essential packages:
    - apt-utils
    - apt-transport-https
    - ca-certificates
    - git
    - nano
    - wget
    - curl
    - gnupg-agent
    - sudo (1.9.1)
    - openssh-client
    - software-properties-common
- Non-root user set-up
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
- Julia (1.4.2):
    - [Revise.jl](https://github.com/timholy/Revise.jl)
    - [IJulia.jl](https://github.com/JuliaLang/IJulia.jl/)
    - [PyPlot.jl](https://github.com/JuliaPy/PyPlot.jl)
    - [Plots.jl](https://github.com/JuliaPlots/Plots.jl)

### Download

This image can be downloaded from [Docker Hub](https://hub.docker.com/r/paveloom/dev):

```bash
docker pull paveloom/dev:0.3.0
```

or from [GitHub Packages](https://github.com/paveloom-d/dev/packages):

```bash
docker pull docker.pkg.github.com/paveloom-d/dev/dev:0.3.0
```

### Build, Run, Enter

There is nothing specific when building, although I would recommend squashing the image. This means using docker's `--squash` option, which is an experimental feature. To enable it, be sure to put the following code in `/etc/docker/daemon.json`:

```json
{
    "experimental": true
}
```

To build the image run the following in the root directory (where Dockerfile is located):

```bash
docker build -t image --squash .
```

If you want to develop docker containers inside the container, it is recommended to bind-mount Docker socket when running it as follows:

```bash
docker run -v /var/run/docker.sock:/var/run/docker.sock --name container -t -d image
```

This requires that your local socket has read and write privileges for others group. You can give them like this:

```bash
sudo chmod o+rw /var/run/docker.sock
```

If you don't need this functionality, you can omit the `-v` flag above.

Since Zsh is the default shell, you can enter the container using the following command:

```bash
docker exec -it container zsh
```

There is also a [Makefile](https://github.com/paveloom-d/dev/blob/master/Makefile) published, which I use for the development. You can use it to execute the procedure above as simple as:

```bash
make build
make run
make in
```

The build rule will call [dive](https://github.com/wagoodman/dive), so be sure you have this tool, or just change `dive` to `docker` inside the Makefile. Be mindful though that the build rule here will delete all other images except mine and Alpine's.

### Jupyter

To use Jupyter Notebook / Jupyter Lab you will need to do two things.

First, publish the `8888` port when running a container:

```bash
docker run -p 8888:8888 --name container -t -d image
```

Secondly, when in the container, make notebook server listen on `0.0.0.0`:

```bash
jupyter notebook --ip 0.0.0.0 --no-browser
```

There are convenient aliases for the last step: `jnote` for Jupyter Notebook and `jlab` for Jupyter Lab.

### Development

There is a ZenHub board, so make sure you have installed the extension to see in which pipelines the issues are.

### Key bindings

This image contains key bindings for deleting words before and after the cursor: <kbd>Ctrl+Backspace</kbd> and <kbd>Ctrl+Delete</kbd> respectively. However, if you are using Windows Terminal, you may find out that the first one doesn't work when using SSH. This has been discussed [here](https://github.com/microsoft/terminal/issues/755), and one of the solutions that you may use is this [AutoHotkey](https://www.autohotkey.com/) script:

```autohotkey
; For Windows Terminal: deletes the previous word
#IfWinActive ahk_exe WindowsTerminal.exe ; Only apply when this window is active
^backspace::
    Send, ^H
return
#IfWinActive ; Turn off context sensitivity
```

### Color theme

Different terminals (like Xterm), programs (like Visual Studio Code) and utilities (like PuTTY) have their own color pallettes. So current theme may look ugly depending on what you use to enter the container. Since it's my image, I made it look more or less attractive when using [Windows Terminal](https://github.com/microsoft/terminal) with the following scheme:

```json
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
```

This one is based on [synthwave-everything](https://atomcorp.github.io/themes/?theme=synthwave-everything), which, I guess, was supposed to be used for local development. I made some changes to make it usable for remote development. So, with this being set up correctly, it should be looking something like this:

![](https://github.com/paveloom-d/dev/raw/master/.github/pictures/colors.png)
