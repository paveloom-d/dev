# Description

### A notice

If you are unsure, please refer to the description on the last commit on the
[`master`](https://github.com/paveloom-d/dev/tree/master) branch.

### What is this?

As the short description says, this is a Docker image containing my development environment.
The main reason for creation is the desire to get rid of setting up environments from
scratch when transitioning between machines. Designed initially for remote development,
but can be used both locally and in the cloud.

### Okay, what's inside?

Well, what's not there? The list is very large and varied,
so see all the details under the spoiler:

<details>
<summary>Content of the image</summary>
<ul>
  <li>Base image: Ubuntu (20.04)</li>
  <li>Essential packages:</li>
  <ul>
    <li><code>apt-utils</code></li>
    <li><code>apt-transport-https</code></li>
    <li><code>dialog</code></li>
    <li><code>dumb-init</code></li>
    <li><code>htop</code></li>
    <li><code>ca-certificates</code></li>
    <li><code>git</code></li>
    <li><code>make</code></li>
    <li><code>ncdu</code></li>
    <li><code>zip</code></li>
    <li><code>unzip</code></li>
    <li><code>nano</code></li>
    <li><code>less</code></li>
    <li><code>wget</code></li>
    <li><code>curl</code></li>
    <li><code>gnupg-agent</code></li>
    <li><a href="https://github.com/sudo-project/sudo"><code>sudo</code></a> (1.9.1)</li>
    <li><code>ssh</code></li>
    <li><code>locales</code></li>
    <li><code>software-properties-common</code></li>
  </ul>
  <li>Non-root user set-up</li>
  <li><a href="#what-is-this-keychain-thing">Keychain to manage your SSH keys</a></li>
  <li><a href="#keybindings">Key bindings</a></li>
  <li>X2Go Server and XFCE Desktop Environment</li>
  <li>Midori Web Browser</li>
  <li><a href="#users-scripts">Auxiliary user scripts</a></li>
  <li>Zsh as the default shell:</li>
  <ul>
    <li><a href="https://github.com/ohmyzsh/ohmyzsh">OhMyZsh</a></li>
    <ul>
      <li>Additional plugins:</li>
      <ul>
        <li>
          <a href="https://github.com/zsh-users/zsh-autosuggestions">
            <code>
              zsh-autosuggestions
            </code>
          </a>
        </li>
      </ul>
      <li><a href="#color-theme">Theme adjustments</a></li>
    </ul>
  </ul>
  <li>Docker</li>
  <li>Python:</li>
  <ul>
    <li><code>python3-dev</code></li>
    <li><code>python3-pip</code></li>
    <li>Packages:</li>
    <ul>
      <li><code>wheel</code></li>
      <li><code>numpy</code></li>
      <li><code>matplotlib</code></li>
    </ul>
  </ul>
  <li>Jupyter:</li>
  <ul>
    <li><code>jupyter</code></li>
    <li><code>jupyterlab</code></li>
    <li><a href="#jupyter">Aliases to run a notebook server</a></li>
  </ul>
  <li>Julia (1.5.0):</li>
  <ul>
    <li><a href="https://github.com/JuliaDocs/Documenter.jl">Documenter.jl</a></li>
    <li><a href="https://github.com/fredrikekre/Literate.jl">Literate.jl</a></li>
    <li><a href="https://github.com/timholy/Revise.jl">Revise.jl</a></li>
    <li><a href="https://github.com/JuliaLang/IJulia.jl">IJulia.jl</a></li>
    <li><a href="https://github.com/JuliaPy/PyPlot.jl">PyPlot.jl</a></li>
    <li><a href="https://github.com/JuliaPlots/Plots.jl">Plots.jl</a></li>
  </ul>
  <li>Node.js and npm</li>
  <li>Rclone</li>
  <li>TexLive:</li>
  <ul>
    <li><code>dvipng</code></li>
    <li><code>texlive-latex-extra</code></li>
    <li><code>texlive-fonts-extra</code></li>
    <li><code>texlive-lang-cyrillic</code></li>
    <li><code>cm-super</code></li>
  </ul>
  <li><a href="#code-server"><code>code-server</code></a></li>
</ul>
</details>

### How do I use it?

The image can be pulled from [Docker Hub](https://hub.docker.com/r/paveloom/dev):

```bash
docker pull paveloom/dev:0.3.3
```

or from [GitHub Packages](https://github.com/paveloom-d/dev/packages):

```bash
docker pull docker.pkg.github.com/paveloom-d/dev/dev:0.3.3
```

After that, you can run the Docker container based on it or create another image using
that as a base.

### Can I build the image myself?

Totally, but know that it's going to take some time. There is nothing special when building,
although I would recommend squashing the image. By this means using the Docker's `--squash`
flag, which is an experimental feature. To enable it, make sure you have the following code
in the `/etc/docker/daemon.json` file:

```json
{
    "experimental": true
}
```

To build the image, execute the following in the repository's root directory:

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

### Can I use Docker from the inside?

Yes, but this requires that your local Docker socket is bind-mounted and that the `others`
group has read and write privileges relative to it. You can give these privileges as
follows:

```bash
sudo chmod o+rw /var/run/docker.sock
```

After that, the container should be run with an additional `-v` flag:

```bash
docker run -v /var/run/docker.sock:/var/run/docker.sock --name container -t -d image
```

### I see Jupyter installed there. How do I use it?

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

### I don't see any password requests. Is that normal?

Yes. The system will not ask the user to enter a password (this makes it
easier to run administrator commands, for instance), but it will be asked if you try to
establish an [SSH connection](#ssh) with a container from the outside. If no password has
been set, the connection cannot be established. If you want to set this password, run
`passwd $USER` as root.

### So I can connect to this container over SSH?

Absolutely. Although to establish an SSH connection to the container, you need to map the
container's `22` port to any other port available and not occupied on the host machine
(for example, `5001`).

This can be accomplished by running a container using the `-p` flag:

```bash
docker run -p 5001:22 --name container -t -d image
```

Remember, you can't publish new ports when the container is already running.

If the SSH service is running inside the container (it starts automatically when you
open a new shell instance, although you can check this by running `service ssh status`),
you can SSH into the container as follows:

```bash
ssh -p 5001 username@remote
```

This will prompt for the `username`'s password. If you haven't done this yet,
[set it up](#users-password).

### What is this Keychain thing?

Instead of calling `ssh-add` every time you log-in, you can add your SSH key(s) using
[`keychain`](https://linux.die.net/man/1/keychain). The corresponding lines are present
in the `~/.zshrc`, just uncomment them and specify your keys.

### What key bindings are offered?

This image provides keyboard shortcuts to delete a word before and after the cursor:
<kbd>Ctrl+Backspace</kbd> and <kbd>Ctrl+Delete</kbd> respectively. However, if you are
using [Windows Terminal](https://github.com/microsoft/terminal), you may find that the
first one does not work. This has been discussed
[here](https://github.com/microsoft/terminal/issues/755), and one of the solutions that
you can use is this [AutoHotkey](https://www.autohotkey.com/) script:

```autohotkey
; For Windows Terminal: deletes the previous word
#IfWinActive ahk_exe WindowsTerminal.exe ; Only apply when this window is active
^backspace::
    Send, ^H
return
#IfWinActive ; Turn off context sensitivity
```

### Auxiliary user scripts, huh? What's that?

The image provides auxiliary scripts that can help the user create SSH and GPG keys and
connect them to an account on GitHub. They are located in `~/Scripts`.

### Color scheme? What does that look like?

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

### What is `code-server`?

[`code-server`](https://github.com/cdr/code-server) is a
[Visual Studio Code](https://code.visualstudio.com/) fork to run IDE in the browser.
By default, it uses port `8080`, so this port must be published before running the
container:

```bash
docker run -p 8080:8080 --name container -t -d image
```
