#!bin/sh
SCRIPT=$(realpath "$0")
SCRIPTPATH=$(dirname "$SCRIPT")

if [ "$EUID" -eq 0 ]
  then echo "Do not run this script as sudo (sh start.sh)"
  exit
fi

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
