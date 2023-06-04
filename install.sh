SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

cd ~

sudo apt install -y awesome sddm rofi thunar firefox
sudo systemctl enable sddm

cd $SCRIPT_DIR
mkdir ~/.config
mkdir ~/.config/awesome
cp -r awesome/* ~/.config/awesome/*
cp "50-mouse-acceleration.conf" /usr/share/X11/xorg.conf.d/50-mouse-acceleration.conf

cd
