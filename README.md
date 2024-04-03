# NUB31's dotfiles

<div align="center">
    <img src="assets/screenshot.png" width='800px'/>
</div>

## Installation

```bash
sudo apt update && sudo apt upgrade -y
sudo apt install -y xorg
sudo apt install -y lightdm
sudo systemctl enable lightdm
sudo apt install -y libxcb-xfixes0-dev git
sudo apt-get build-dep -y awesome
git clone https://github.com/awesomewm/awesome
cd awesome
make package
sudo cp awesome.desktop /usr/share/xsessions/
cd ../
sudo rm -rf awesome
mkdir -p ~/.config/
cp -r dotfiles/* $HOME
sudo mkdir -p /usr/share/cursors/xorg-x11
sudo ln -s ~/.icons /usr/share/cursors/xorg-x11/
sudo bash -c "echo 'Section \"InputClass\" Identifier \"My Mouse\" Driver \"libinput\" MatchIsPointer \"yes\" Option \"AccelProfile\" \"flat\" EndSection' > /etc/X11/xorg.conf.d/50-mouse-acceleration.conf"
echo 'gtk-font-name="Cantarell 11"' >> ~/.config/.gtkrc-2.0
sudo bash -c "echo 'Section \"Files\" FontPath \"/usr/share/fonts/cantarell/\" EndSection' > /etc/X11/xorg.conf.d/10-fonts.conf"
gsettings set org.cinnamon.desktop.default-applications.terminal exec alacritty
sudo apt install curl
curl -sS https://starship.rs/install.sh | sh
echo "eval "$(starship init bash)"" >> "$HOME/.bashrc"
sudo apt install -my feh picom rofi firefox nemo imagemagick gpick ffmpeg i3lock scrot pavucontrol nemo
```
