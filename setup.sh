sudo apt update -y
sudo apt upgrade -y
sudo apt install -y xorg awesome lightdm feh picom thunar

# optional
sudo apt install -y firefox-esr kitty lxappearance git gedit thunderbird

cp -r ./.config ~/
cp -r ./.wallpapers ~/
cp -r ./.icons ~/

sudo mkdir /usr/share/cursors
sudo mkdir /usr/share/cursors/xorg-x11
sudo ln -s ~/.icons /usr/share/cursors/xorg-x11/

# optional
lxappearance
