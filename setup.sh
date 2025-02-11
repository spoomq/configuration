#!/bin/bash

set -e

# updates & installs
echo -e "updating system..."
sudo apt update && sudo apt upgrade -y

echo -e "installing packages..."
sudo add-apt-repository universe
sudo apt install build-essential vim git net-tools gnome-tweaks neofetch cmatrix -y

echo -e "removing & installing snap packages..."
sudo snap remove --purge firefox
sudo snap install chromium spotify

echo -e "installing alacritty..."
sudo add-apt-repository ppa:aslatter/ppa -y
sudo apt install alacritty -y
mkdir -p ~/.config/alacritty/themes
git clone https://github.com/alacritty/alacritty-theme ~/.config/alacritty/themes

echo -e "remove packages..."
sudo apt remove gnome-shell-extension-ubuntu-dock gnome-terminal -y
sudo apt autoremove -y

# .bashrc
sleep 1
echo -e "replacing .bashrc...\n"
rm -f ~/.bashrc
cp ./.bashrc ~

# vim
echo -e "moving vim config...\n"
cp ./.vimrc ~/.vimrc;

# tmux
sleep 1
echo -e "moving tmux config...\n"
cp ./.tmux.conf ~/.tmux.conf;

# alacritty
sleep 1
echo -e "moving alacritty config...\n"
mkdir ~/.config/alacritty
cp ./alacritty/alacritty.toml ~/.config/alacritty/;

# backgrounds
# echo -e "moving backgrounds...\n"
# mkdir ~/.local/share/backgrounds
# cp ./backgrounds/* ~/.local/share/backgrounds/

# system
echo -e "changing background...\n"
gsettings set org.gnome.desktop.background picture-uri ''
gsettings set org.gnome.desktop.background primary-color '#000000'

sleep 1
echo -e "done.\n"

read -p "\nwould you like to reboot? " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
  reboot
else
  echo ok.
  return
fi
