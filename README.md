# Dotfiles

_Automated dotfiles install & automated macOS/ Ubuntu setup scripts_

![GitHub Actions Workflow Status](https://img.shields.io/github/actions/workflow/status/MarkHershey/dotfiles/shellcheck.yml?style=flat-square&label=ShellCheck)
![GitHub Actions Workflow Status](https://img.shields.io/github/actions/workflow/status/MarkHershey/dotfiles/ci_ubuntu.yml?style=flat-square&label=CI-Ubuntu)
![GitHub Actions Workflow Status](https://img.shields.io/github/actions/workflow/status/MarkHershey/dotfiles/ci_ubuntu_curl.yml?style=flat-square&label=CI-Ubuntu-Curl)
![GitHub Actions Workflow Status](https://img.shields.io/github/actions/workflow/status/MarkHershey/dotfiles/ci_macos.yml?style=flat-square&label=CI-macOS)

It's a good idea to use a version control system (VCS) like `git` to manage your dotfiles in one place and a script to bootstrap all your dotfiles, so that every time you set up a new machine or a remote server, you just need to clone the repository and run the `./install` script.

The install script is **idempotent**, meaning that you could run the script repeatedly without causing any side effects.

Hope this repository gives you inspiration.

## Run the Script

To run the automated dotfiles-install script for Ubuntu or macOS, choose either:

-   Install with Git

```bash
git clone https://github.com/MarkHershey/dotfiles.git && \
cd dotfiles && \
./install
```

-   Install without Git

```bash
bash -c "$(curl -fsSL https://raw.githubusercontent.com/MarkHershey/dotfiles/master/curl_install)"
```

## Before You Run the Script

### Fork this Repository

Alternatively, clone this repo and make it your own.

```bash
git clone https://github.com/MarkHershey/dotfiles.git && \
cd dotfiles && \
rm -rf .git && \
git init
```

### Configurations

1. Understand the scripts before you run it, modify it accordingly to suit your own needs.
2. You should definitely modify the files that contain personal/regional information, such as:
    - [`git/gitconfig`](git/gitconfig) contains git user information.
    - [`macos/macOS_custom_setup.sh`](https://github.com/MarkHershey/dotfiles/blob/eb7cb134a58ee618c10bbc91f16596be1cca36e1/macos/macOS_custom_setup.sh#L105) Line 105-115 contains language & timezone settings for macOS.

### Try it in Docker

Optionally, if you are not sure if the script will deliver what you wanted, you can try the setup in a Docker container.

-   Build image from source

    ```bash
    git clone https://github.com/MarkHershey/dotfiles.git && \
    cd dotfiles && \
    docker build -t ubuntu-dev .
    ```

    Then, run the local image

    ```bash
    docker run -it ubuntu-dev
    ```

## What is included?

-   [`zsh`](https://en.wikipedia.org/wiki/Z_shell)
    -   Plugin Manager
        -   [oh-my-zsh](https://github.com/ohmyzsh/ohmyzsh)
    -   Built-in Plugins
        -   [git](https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/git)
        -   [tmux](https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/tmux)
        -   [sudo](https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/sudo)
        -   [docker](https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/docker)
        -   [colorize](https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/colorize)
        -   [command-not-found](https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/command-not-found)
    -   Custom Plugins
        -   [zsh-completions](https://github.com/zsh-users/zsh-completions)
        -   [zsh-syntax-highlighting](https://github.com/zsh-users/zsh-syntax-highlighting)
    -   Theme
        -   [powerlevel10k](https://github.com/romkatv/powerlevel10k)
-   [`tmux`](https://github.com/tmux/tmux/wiki)
-   [`vim`](https://www.vim.org/)
    -   Plugin Manager
        -   [Vundle](https://github.com/VundleVim/Vundle.vim)
    -   Plugins
        -   [vim-airline / vim-airline](https://github.com/vim-airline/vim-airline)
        -   [preservim / nerdtree](https://github.com/preservim/nerdtree)
        -   [python-mode / python-mode](https://github.com/python-mode/python-mode)
        -   [zxqfl / tabnine-vim](https://github.com/zxqfl/tabnine-vim)

## TODOs

-   [ ] Automate Custom Keybindings for Ubuntu. [Reference](https://askubuntu.com/a/597414)

## References

-   [donnemartin / dev-setup / osx.sh](https://github.com/donnemartin/dev-setup/blob/master/osx.sh)
-   [mathiasbynens / dotfiles / .macos](https://github.com/mathiasbynens/dotfiles/blob/main/.macos)
-   [teddysun / across / bench.sh](https://github.com/teddysun/across/blob/master/bench.sh)

## LICENSE

Copyright (c) 2020-2023 Mark Huang - [MIT LICENSE](LICENSE)
