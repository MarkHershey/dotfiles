# dotfile - server edition
Dotfile for Quick Shell Setup of Remote Server

### Clone this repo
```bash
cd ~
git clone https://github.com/MarkHershey/dotfile-server.git
```

### [ZSH (Z Shell)](http://zsh.sourceforge.net/)

##### Install Oh My ZSH
For Ubuntu:

```bash
sudo apt update
sudo apt install zsh
```
For other OS, refers to [this](https://github.com/ohmyzsh/ohmyzsh/wiki/Installing-ZSH).

Verify install
```bash
zsh --version
```



##### Change default shell for current user
```bash
chsh -s $(which zsh)
```

Verify default shell
```bash
echo $SHELL
```

should return `/usr/bin/zsh` or `/bin/zsh` or similar.

### [Oh My ZSH](https://github.com/ohmyzsh/ohmyzsh)

##### Install Oh My ZSH
```bash
sh -c "$(wget -O- https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
```

or

```bash
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
```


### [Zsh Syntax Highlighting](https://github.com/zsh-users/zsh-syntax-highlighting)

##### Install zsh-syntax-highlighting into Oh My ZSH plugins folder
```bash
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
```


### [Powerlevel 10k](https://github.com/romkatv/powerlevel10k)

##### Install Powerlevel 10k
```bash
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/themes/powerlevel10k
```

##### Copy dotfile

```bash
cp ~/dotfile-server/.zshrc ~/.zshrc
cp ~/dotfile-server/.p10k.zsh ~/.p10k.zsh

source ~/.zshrc
source ~/.p10k.zsh
```

##### Configure Wizard
```bash
p10k configure
```

### Vim

##### Install Vim
```bash
sudo apt remove --assume-yes vim-tiny
sudo apt update
sudo apt install --assume-yes vim
vi --version
```

##### Copy dotfile

```bash
cp ~/dotfile-server/.vimrc ~/.vimrc

source ~/.vimrc
```

### Others

```bash
sudo apt-get install libncurses5-dev libncursesw5-dev
sudo apt install git
sudo apt install make
sudo apt install build-essential
sudo apt install tree
```
