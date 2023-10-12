#!/bin/bash

set -e

# updates & installs
echo "updating system..."
sudo apt update && sudo apt upgrade -y

echo "installing packages..."
sudo add-apt-repository universe
sudo apt install build-essential, vim, git, net-tools, gnome-tweaks, neofetch, cmatrix

echo "removing & installing snap packages..."
sudo snap remove --purge firefox
sudo snap install chromium spotify

echo "installing alacritty..."
sudo add-apt-repository ppa:aslatter/ppa -y
sudo apt install alacritty

echo "remove packages..."
sudo apt remove gnome-shell-extention-ubuntu-dock gnome-terminal
sudo apt autoremove

# .bashrc
sleep 1
echo "replacing .bashrc...\n"
rm -f ~/.bashrc
cp ./.bashrc ~

# vim
echo "moving vim config...\n"
cp ./.vimrc ~/.vimrc;

# tmux
sleep 1
echo "moving tmux config...\n"
cp ./.tmux.conf ~/.tmux.conf;

# alacritty
sleep 1
echo "moving alacritty config...\n"
mkdir ~/.config/alacritty
cp ./.config/alacritty/alacritty.yml ~/.config/alacritty/alacritty.yml;

# system
echo "changing background...\n"
gsettings set org.gnome.desktop.background picture-uri file:///home/user/.local/share/backgrounds/horse.jpg

sleep 1
echo "changing theme...\n"
gsettings set org.gnome.desktop.interface gtk-theme 'Yaru-dark'

sleep 2
echo "done.\n"

read -p "would you like to logout? " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
  logout
else
  echo "ok."
  return
fi
