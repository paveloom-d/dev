# Description

### Contents

- Base image: alpine (3.12.0)
- Basic packages:
    - sudo (1.9.0-r0)
    - git (2.26.2-r0)
    - nano (4.9.3-r0)
    - nano-syntax (4.9.3-r0)
    - openssh (8.3_p1-r0)
    - shadow (4.8.1-r0)
- User (paveloom) set-up
- Zsh (5.8-r1) as default shell
- [OhMyZsh](https://github.com/ohmyzsh/ohmyzsh):
    - Additional plugins:
        - [Zsh-autosuggestions](https://github.com/zsh-users/zsh-autosuggestions)
    - Theme adjustments

### Download

This image can be downloaded from [Docker Hub](https://hub.docker.com/r/paveloom/dev):

```bash
docker pull paveloom/dev
```

or from [GitHub Packages](https://github.com/paveloom-d/dev/packages):

```bash
docker pull docker.pkg.github.com/paveloom-d/dev/dev:0.1.0
```


### Build, Run, Enter

There is nothing specific when building, although I would recommend squashing the image. In the root directory (where Dockerfile is located) run the following:

```bash
docker build -t image --squash .
```

If you want to develop docker containers inside the container, it is recommended to bind-mount Docker socket when running it, as follows:

```bash
docker run -v /var/run/docker.sock:/var/run/docker.sock --name container -t -d image
```

This requires that your local socket has read and write privileges for others group. You can give them like this:

```bash
sudo chmod o+rw /var/run/docker.sock
```

If you don't need this functionality, you can omit the `-v` flag above.

Since Zsh is the default shell, enter the container using the following command:

```bash
docker exec -it container zsh
```

There is also a [Makefile](https://github.com/paveloom-d/dev/blob/master/Makefile) published, which I use for the development. You can use it to execute the procedure above as simple as:

```bash
make build
make run
make in
```

Build rule will call [dive](https://github.com/wagoodman/dive), so be sure you have this tool, or just change `dive` to `build` inside Makefile. Be mindful though that the build rule here will delete all other images except mine and Alpine's.

### Development

There is a ZenHub board, so make sure you have installed the extension to see in which pipelines the issues are.

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

This one is based on [synthwave-everything](https://atomcorp.github.io/themes/?theme=synthwave-everything), which, I believe, was supposed to be used for local development. I made some changes to make it usable for remote development. So, with this being set up correctly, it should be looking something like this:

![](https://github.com/paveloom-d/dev/raw/master/.github/pictures/colors.png)
