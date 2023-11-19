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
cp ./.config/alacritty/alacritty.yml ~/.config/alacritty/alacritty.yml;

# backgrounds
echo -e "moving backgrounds...\n"
cp ./backgrounds/* ~/.local/share/backgrounds/

# system
echo -e "changing background...\n"
gsettings set org.gnome.desktop.background picture-uri file:///home/user/.local/share/backgrounds/horse.png

sleep 1
echo -e "changing theme...\n"
gsettings set org.gnome.desktop.interface gtk-theme 'Yaru-dark'

sleep 2
echo -e "done.\n"

read -p "would you like to reboot?" -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
  reboot
else
  echo ok.
  return
fi
