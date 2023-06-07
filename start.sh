#!bin/sh
SCRIPT=$(realpath "$0")
SCRIPTPATH=$(dirname "$SCRIPT")

if ! command -v yay &> /dev/null
then
  echo "yay is not installed. Starting yay installation"
  sudo pacman --noconfirm -S git
  cd /opt
  sudo git clone https://aur.archlinux.org/yay-git.git
  sudo chown -R $USER ./yay-git
  cd yay-git
  makepkg -si
fi

sudo sh "$SCRIPTPATH/setup.sh"
