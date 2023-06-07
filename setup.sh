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

PS3="Please select the configuration you want: "
select character in "Minimal  (Only includes the strictly necesary packages: xorg, awesome etc.)" "Default  (Includes packages requried by the included configuration: feh, picom, rofi etc.)" "Full     (Also includes some packages i use: wine, steam, lutris, rider, thunderbird etc.)"; 
do   
  if [ ! -z "$character" ] ;     
  then        
    break    
  fi; 
done

echo "Updating installed packages"
yay -Syu --noconfirm

echo "Installing xorg, awesome"
# System critical
yay -S --noconfirm xorg xterm awesome-git sddm 
sudo systemctl enable sddm

# Config defined applications
if [ $REPLY == 2 ]
then
  echo "Copying wallpaper"
  cp -r .wallpapers ~/
  echo "Installing config specific programs"
  yay -S --noconfirm feh picom-git rofi firefox kitty visual-studio-code-bin Adwaita-dark Adwaita nemo
fi

# Personal prefrence
if [ $REPLY == 3 ]
then
  echo "Installing personal programs"
  yay -S --noconfirm lxappearance thunderbird pavucontrol steam wine lutris minecraft-launcher rider yuzu openvpn neofetch
fi

cd $SCRIPTPATH

# Apply awesomewm config
echo "Applying awesomewm configuration"
cp -r .config ~/

# Custom cursor
while true; do
    read -p "Do you wish to use the provided cursor (Bibata-Modern-Ice)? " yn
    case $yn in
        [Yy]* ) cp -r .icons ~/; mkdir /usr/share/cursors; mkdir /usr/share/cursors/xorg-x11; ln -s ~/.icons /usr/share/cursors/xorg-x11/;;
        [Nn]* ) break;;
        * ) echo "Please answer yes or no.";;
    esac
done

# Mouse acceleration
while true; do
    read -p "Do you wish to disable mouse acceleration? " yn
    case $yn in
        [Yy]* ) sudo bash -c "echo 'Section \"InputClass\"Identifier \"My Mouse\"Driver \"libinput\"MatchIsPointer \"yes\"Option \"AccelProfile\" \"flat\"EndSection' > /etc/X11/xorg.conf.d/50-mouse-acceleration.conf"; break;;
        [Nn]* ) break;;
        * ) echo "Please answer yes or no.";;
    esac
done

# Config defined applications
if [ $REPLY == 2 ]
then
  echo "Setting kitty as default terminal for nemo file browser"
  gsettings set org.cinnamon.desktop.default-applications.terminal exec kitty
fi

# Final command if neofetch is installed
if [ $REPLY == 3 ]
then
  neofetch
fi
