# Dotfiles

*personal dotfiles & quick machine setup scripts*

![](https://github.com/MarkHershey/dotfiles/workflows/Shellcheck/badge.svg?branch=master)
![](https://github.com/MarkHershey/dotfiles/workflows/CI-ubuntu/badge.svg?branch=master)
![](https://github.com/MarkHershey/dotfiles/workflows/CI-macOS/badge.svg?branch=master)

---

## Install

### Bootstrap Install w/ Git

For Ubuntu & macOS:

```bash
git clone https://github.com/MarkHershey/dotfiles.git ~/dotfiles && cd ~/dotfiles && ./install
```

### Bootstrap Install w/ Curl

```bash
sh -c "$(curl -fsSL https://raw.githubusercontent.com/MarkHershey/dotfiles/master/curl_install)"
```

## What is included?

- `zsh`
    - Plugin Manager
        - [oh-my-zsh](https://github.com/ohmyzsh/ohmyzsh)
    - Built-in Plugins
        - [git](https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/git)
        - [tmux](https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/tmux)
        - [sudo](https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/sudo)
        - [docker](https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/docker)
        - [colorize](https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/colorize)
        - [command-not-found](https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/command-not-found)
    - Custom Plugins
        - [zsh-completions](https://github.com/zsh-users/zsh-completions)
        - [zsh-syntax-highlighting](https://github.com/zsh-users/zsh-syntax-highlighting)
    - Theme
        - [powerlevel10k](https://github.com/romkatv/powerlevel10k)
- [`tmux`](https://github.com/tmux/tmux/wiki)
- [`vim`](https://www.vim.org/)
    - Plugin Manager
        - [Vundle](https://github.com/VundleVim/Vundle.vim)
    - Plugins
        - [vim-airline / vim-airline](https://github.com/vim-airline/vim-airline)
        - [preservim / nerdtree](https://github.com/preservim/nerdtree)
        - [python-mode / python-mode](https://github.com/python-mode/python-mode)
        - [zxqfl / tabnine-vim](https://github.com/zxqfl/tabnine-vim)

## LICENSE

Copyright (c) 2020-2021 Mark Huang - [MIT LICENSE](LICENSE)
