# vimrc

### Set up

1. Copy `.vimrc` to home folder
    ```bash
    cp vimrc/.vimrc ~/.vimrc
    ```

2. Clone `Vundle.vim` into  `~/.vim/bundle/`
    ```bash
    git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
    ```

3. Launch `vim` and run `:PluginInstall`
    ```bash
    vim
    ```

4. Build `YouCompleteMe`:
    ```bash
    sudo apt install build-essential cmake vim python3-dev golang-go
    cd ~/.vim/bundle/YouCompleteMe
    python3 install.py --all
    ```

### Vim Plugin Manager

In this `vimrc`, a Vim plugin manager called `Vundle` is used. 

- [VundleVim / Vundle.vim](https://github.com/VundleVim/Vundle.vim)


### Included Vim Plugin

- [vim-airline / vim-airline](https://github.com/vim-airline/vim-airline)
    - Status line at the bottom of each vim window
- [preservim / nerdtree](https://github.com/preservim/nerdtree)
    - File tree explorer
- [preservim / nerdcommenter](https://github.com/preservim/nerdcommenter)
- [ycm-core / YouCompleteMe](https://github.com/ycm-core/YouCompleteMe)
    - A code-completion engine for Vim
- [python-mode / python-mode](https://github.com/python-mode/python-mode)






### References

- [Vim Awesome](https://vimawesome.com/)
    - A web tool to discover awesome vim plugins  
- [The ultimate Vim configuration: amix / vimrc](https://github.com/amix/vimrc)
