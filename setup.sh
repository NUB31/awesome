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
yay -S firefox kitty lxappearance git thunderbird nautilus gedit

cp -r ./.config ~/
cp -r ./.wallpapers ~/
cp -r ./.icons ~/

mkdir /usr/share/cursors
mkdir /usr/share/cursors/xorg-x11
ln -s ~/.icons /usr/share/cursors/xorg-x11/
