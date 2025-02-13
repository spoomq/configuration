#!/bin/bash

set -e

# updates & installs
echo -e "updating system..."
sudo apt update && sudo apt upgrade -y

echo -e "installing packages..."
sudo add-apt-repository universe
sudo apt install build-essential curl vim git net-tools gnome-tweaks neofetch cmatrix -y

echo -e "removing & installing snap packages..."
sudo snap remove --purge firefox
sudo snap install chromium spotify

echo -e "installing alacritty..."
git clone https://github.com/alacritty/alacritty.git
cd alacritty && pwd
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
source ~/.cargo/env
rustup override set stable
rustup update stable
sudo apt install cmake g++ pkg-config libfreetype6-dev libfontconfig1-dev libxcb-xfixes0-dev libxkbcommon-dev python3
cargo build --release
sudo tic -xe alacritty,alacritty-direct extra/alacritty.info
sudo cp ./target/release/alacritty /usr/bin/
#sudo cp ./extra/logo/alacritty-term.svg /usr/share/pixmaps/Alacritty.svg
#sudo cp ./extra/linux/Alacritty.desktop /usr/share/applications
#sudo update-desktop-database
rustup self uninstall
cd - && pwd
sudo update-alternatives --set x-terminal-emulator /usr/bin/alacritty
echo -e "alacritty done."

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
mkdir -p ~/.config/alacritty/themes
cp ./alacritty.toml ~/.config/alacritty/;
git clone https://github.com/alacritty/alacritty-theme ~/.config/alacritty/themes

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
