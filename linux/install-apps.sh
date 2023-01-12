#!/usr/bin/env bash

sudo snap install brave || echo "ERROR: Unable to install Brave via snap"
sudo snap install telegram-desktop || echo "ERROR: Unable to install Telegram via snap"
sudo snap install slack || echo "ERROR: Unable to install Slack via snap"
sudo snap install 1password || echo "ERROR: Unable to install 1Password via snap"
sudo snap install spotify || echo "ERROR: Unable to install Spotify via snap"
sudo snap install code --classic || echo "ERROR: Unable to install VS Code via snap"
sudo snap install htop || echo "ERROR: Unable to install htop via snap"
sudo apt update && sudo apt install terminator -y || echo "ERROR: Unable to install Terminator via apt"
sudo apt update && sudo apt install gnome-tweaks -y  || echo "ERROR: Unable to install Gnome Tweaks via apt"