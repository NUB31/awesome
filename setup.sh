sudo apt update -y
sudo apt upgrade -y
sudo apt install -y xorg awesome lightdm feh picom thunar

# optional
sudo apt install -y firefox-esr nvidia-driver kitty lxappearance git gedit thunderbird

cp -r ./* ~/

sudo mkdir /usr/share/cursors
sudo mkdir /usr/share/cursors/xorg-x11
sudo ln -s ~/.icons /usr/share/cursors/xorg-x11/

# optional
lxappearance
