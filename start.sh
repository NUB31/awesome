#!bin/sh
SCRIPT=$(realpath "$0")
SCRIPTPATH=$(dirname "$SCRIPT")

if ! command -v yay &> /dev/null
then
  echo "yay is not installed. Starting yay installation"
  pacman --noconfirm -S git
  cd /opt
  git clone https://aur.archlinux.org/yay-git.git
  chown -R $USER ./yay-git
  cd yay-git
  makepkg --asroot -si
fi

sudo sh "$SCRIPTPATH/setup.sh"
