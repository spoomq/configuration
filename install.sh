#!/bin/bash
set -e

sleep 3

echo "Updating System..."
sudo pacman --noconfirm -Syu

echo "Downloading Packages..."
sudo pacman -S --noconfirm --needed - < pkgs

echo "Installing Yay..."
# Yay
git clone https://aur.archlinux.org/yay-git.git
cd ./yay-git && makepkg -si
cd -
mkdir -p ~/.pkgs && mv ./yay-git ~/.pkgs

echo "Installing AUR Packages..."
yes | yay -S --noconfirm picom-jonaburg-git\
  alacritty\
  xclip

# Bash
echo "Replacing .bashrc..."
rm -f ~/.bashrc
cp ./.bashrc ~

# Vim
if [ -f ~/.vimrc ]; then
  echo "Backing Up exisiting vim config..."
  mv ~/.vimrc ~/.vimrc.old;
  cp ./.vimrc ~/.vimrc;
else
  echo "Installing vim config..."
  cp ./.vimrc ~/.vimrc;
fi

# Tmux
if [-f ~/.tmux.conf ]; then
  echo "Backing Up exisiting tmux config..."
  mv ~/.tmux.conf ~/.tmux.conf.old;
  cp ./.tmux.conf ~/.tmux.conf;
else
  echo "Installing tmux config..."
  cp ./.tmux.conf ~/.tmux.conf;
fi

# Xmonad
if [ -d ~/.xmonad ]; then
  echo "Backing Up xmonad config..."
  mkdir ~/.xmonad-old && mv ~/.xmonad/* ~/.xmonad-old;
else
  echo "Installing xmonad config..."
  mkdir -p ~/.xmonad && cp ./.xmonad/xmonad.hs ~/.xmonad;
fi



mkdir -p ~/.config/
  # Picom
  if [ -f ~/.config/picom.conf ]; then
    echo "Backing Up exisiting picom config..."
    mv ~/.config/picom.conf ~/.config/picom.conf.old;
    cp ./.config/picom.conf ~/.config/picom.conf;
  else
    echo "Installing picom config..."
    cp ./.config/picom.conf ~/.config/picom.conf;
  fi

  # Alacritty
  if [ -f ~/.config/alacritty.yml ]; then
    echo "Backing Up exisiting alacritty config..."
    mv ~/.config/alacritty.yml ~/.config/alacritty.yml.old;
    cp ./.config/alacritty.yml ~/.config/alacritty.yml;
  else
    echo "Installing alacritty config..."
    cp ./.config/alacritty.yml ~/.config/alacritty.yml;
  fi

  # Xmobar
  if [ -d ~/.config/xmobar ]; then
    echo "Backing Up exisiting xmobar config..."
    mv ~/.config/xmobar/.xmobarrc ~/.config/xmobar/.xmobarrc.old;
    cp ./.config/xmobar/.xmobarrc ~/.config/xmobar;
  else
    echo "Installing xmobar config..."
    mkdir -p ~/.config/xmobar && cp ./.config/xmobar/.xmobarrc ~/.config/xmobar;
  fi

# Fonts
# echo "Installing Fonts..."
# mkdir -p ~/.local/share/fonts
# cp -r ./.fonts/* ~/.local/share/fonts
# fc-cache -f

sleep 3
echo "OK."
