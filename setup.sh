echo "deb http://deb.debian.org/debian bookworm main non-free-firmware\ndeb-src http://deb.debian.org/debian bookworm main non-free-firmware\n\ndeb http://deb.debian.org/debian-security/ bookworm-security main non-free-firmware\ndeb-src http://deb.debian.org/debian-security/ bookworm-security main non-free-firmware\n\ndeb http://deb.debian.org/debian bookworm-updates main non-free-firmware\ndeb-src http://deb.debian.org/debian bookworm-updates main non-free-firmware" > /etc/apt/sources.list

apt update -y
apt upgrade -y
apt install -y xorg awesome lightdm feh picom

# optional
apt install -y firefox-esr kitty lxappearance git thunderbird nautilus gedit

cp -r ./.config ~/
cp -r ./.wallpapers ~/
cp -r ./.icons ~/

mkdir /usr/share/cursors
mkdir /usr/share/cursors/xorg-x11
ln -s ~/.icons /usr/share/cursors/xorg-x11/
