#!/usr/bin/env bash

read -p "Do you want to install Brave? (y/n) " brave
read -p "Do you want to install Telegram Desktop? (y/n) " telegram
read -p "Do you want to install Slack? (y/n) " slack
read -p "Do you want to install 1Password? (y/n) " onepassword
read -p "Do you want to install Spotify? (y/n) " spotify
read -p "Do you want to install Visual Studio Code? (y/n) " vscode
read -p "Do you want to install htop? (y/n) " htop
read -p "Do you want to install Terminator? (y/n) " terminator
read -p "Do you want to install Gnome Tweaks? (y/n) " gnome_tweaks
read -p "Do you want to install FFmpeg? (y/n) " ffmpeg
read -p "Do you want to install mpv? (y/n) " mpv

# set up a counter to keep track of how many packages are installed
counter=0

if [[ $brave =~ ^[Yy]$ ]]
then
    echo "Installing Brave..."
    sudo snap install brave && counter=$((counter+1)) || echo "ERROR: Unable to install Brave via snap"
fi

if [[ $telegram =~ ^[Yy]$ ]]
then
    echo "Installing Telegram..."
    sudo snap install telegram-desktop && counter=$((counter+1)) || echo "ERROR: Unable to install Telegram via snap"
fi

if [[ $slack =~ ^[Yy]$ ]]
then
    echo "Installing Slack..."
    sudo snap install slack && counter=$((counter+1)) || echo "ERROR: Unable to install Slack via snap"
fi

if [[ $onepassword =~ ^[Yy]$ ]]
then
    echo "Installing 1Password..."
    sudo snap install 1password && counter=$((counter+1)) || echo "ERROR: Unable to install 1Password via snap"
fi

if [[ $spotify =~ ^[Yy]$ ]]
then
    echo "Installing Spotify..."
    sudo snap install spotify && counter=$((counter+1)) || echo "ERROR: Unable to install Spotify via snap"
fi

if [[ $vscode =~ ^[Yy]$ ]]
then
    echo "Installing Visual Studio Code..."
    sudo snap install code --classic && counter=$((counter+1)) || echo "ERROR: Unable to install VS Code via snap"
fi

if [[ $htop =~ ^[Yy]$ ]]
then
    echo "Installing htop..."
    sudo snap install htop && counter=$((counter+1)) || echo "ERROR: Unable to install htop via snap"
fi

if [[ $terminator =~ ^[Yy]$ ]]
then
    echo "Installing Terminator..."
    sudo apt update
    sudo apt install terminator -y && counter=$((counter+1)) || echo "ERROR: Unable to install Terminator via apt"
fi

if [[ $gnome_tweaks =~ ^[Yy]$ ]]
then
    echo "Installing Gnome Tweaks..."
    sudo apt update
    sudo apt install gnome-tweaks -y && counter=$((counter+1))  || echo "ERROR: Unable to install Gnome Tweaks via apt"
fi

if [[ $ffmpeg =~ ^[Yy]$ ]]
then
    echo "Installing FFmpeg..."
    sudo apt update
    sudo apt install ffmpeg -y && counter=$((counter+1)) || echo "ERROR: Unable to install FFmpeg via apt"
fi

if [[ $mpv =~ ^[Yy]$ ]]
then
    echo "Installing mpv..."
    sudo add-apt-repository ppa:mc3man/mpv-tests && \
    sudo apt update && \
    sudo apt install mpv -y && counter=$((counter+1)) || echo "ERROR: Unable to install mpv via apt"
fi

echo "Done installing $counter Apps!"
