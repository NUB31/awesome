#!bin/sh
SCRIPT=$(realpath "$0")
SCRIPTPATH=$(dirname "$SCRIPT")

sudo pacman -S git
cd /opt
sudo git clone https://aur.archlinux.org/yay-git.git
sudo chown -R $USER ./yay-git
cd yay-git
makepkg -si

yay -Syu

yay -S xorg xterm awesome-git picom-git sddm feh

systemctl enable sddm

# optional
yay -S firefox kitty lxappearance git thunderbird nemo gedit pavucontrol

cd $SCRIPTPATH

cp -r .config ~/
cp -r .wallpapers ~/
cp -r .icons ~/

mkdir /usr/share/cursors
mkdir /usr/share/cursors/xorg-x11
ln -s ~/.icons /usr/share/cursors/xorg-x11/

echo 'Section "InputClass"Identifier "My Mouse"Driver "libinput"MatchIsPointer "yes"Option "AccelProfile" "flat"EndSection' > /etc/X11/xorg.conf.d/50-mouse-acceleration.conf
gsettings set org.cinnamon.desktop.default-applications.terminal exec kitty
