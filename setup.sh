#!bin/sh
SCRIPT=$(realpath "$0")
SCRIPTPATH=$(dirname "$SCRIPT")

if [ "$USER" == "root" ]
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

echo "Updating installed packages"
yay -Syu --noconfirm

echo "Copying wallpaper"
cp -r .wallpapers ~/

echo "Installing dependencies"
yay -S --noconfirm xorg xterm awesome-git sddm feh picom-git rofi firefox alacritty visual-studio-code-bin Adwaita-dark Adwaita nemo neovim cantarell-fonts otf-cascadia-code

cd $SCRIPTPATH

# Apply awesomewm config
echo "Applying awesomewm configuration"
cp -r .config ~/

# Custom cursor
while true; do
    read -p "Do you wish to use the provided cursor (Bibata-Modern-Ice)? " yn
    case $yn in
        [Yy]* ) cp -r .icons ~/; sudo mkdir /usr/share/cursors; sudo mkdir /usr/share/cursors/xorg-x11; sudo ln -s ~/.icons /usr/share/cursors/xorg-x11/; break;;
        [Nn]* ) break;;
        * ) echo "Please answer yes or no.";;
    esac

done

# Mouse acceleration
while true; do
    read -p "Do you wish to disable mouse acceleration? " yn
    case $yn in
        [Yy]* ) sudo bash -c "echo 'Section \"InputClass\" Identifier \"My Mouse\" Driver \"libinput\" MatchIsPointer \"yes\" Option \"AccelProfile\" \"flat\" EndSection' > /etc/X11/xorg.conf.d/50-mouse-acceleration.conf"; break;;
        [Nn]* ) break;;
        * ) echo "Please answer yes or no.";;
    esac
done

# Cantarell font
while true; do
    read -p "Do you wish to set Cantarell as your default font? " yn
    case $yn in
        [Yy]* ) sudo bash -c "echo 'Section \"Files\" FontPath \"/usr/share/fonts/cantarell/\" EndSection' > /etc/X11/xorg.conf.d/10-fonts.conf"; break;;
        [Nn]* ) break;;
        * ) echo "Please answer yes or no.";;
    esac
done

# Config defined applications
echo "Setting alacritty as default terminal for nemo file browser"
gsettings set org.cinnamon.desktop.default-applications.terminal exec alacritty

echo Installing oh-my-bash
bash -c "$(curl -fsSL https://raw.githubusercontent.com/ohmybash/oh-my-bash/master/tools/install.sh)"

echo applying .bashrc
cp .bashrc ~/
source ~/.bashrc