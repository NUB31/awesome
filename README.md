```bash
SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

cd ~
pacman -S --needed git base-devel
git clone https://aur.archlinux.org/yay-bin.git
cd yay-bin
makepkg -si

cd ~
rm -r yay-bin

yay -S awesome-git sddm pulsemixer playerctl xdg-utils xclip feh maim xdotool rofi picom
sudo systemctl enable sddm

cd $SCRIPT_DIR
mkdir ~/.config
mkdir ~/.config/awesome
mkdir ~/.config/picom
mkdir ~/.config/alacritty
cp -r awesome/* ~/.config/awesome/*
cp -r picom/* ~/.config/picom/*
cp -r alacritty/* ~/.config/alacritty/*

cd
```

# Step 1

Run commands above ^
