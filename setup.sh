#!bin/bash
SCRIPT=$(realpath "$0")
SCRIPTPATH=$(dirname "$SCRIPT")

if [ "$USER" == "root" ]
then echo "Do not run this script as sudo (sh setup.sh)"
    exit
fi

cd "$SCRIPTPATH"

case $1 in
    
    "debian")
        echo "Updating installed packages"
        sudo apt update -y
        sudo apt upgrade -y
        
        echo "Installing dependencies"
        sudo apt install -y xorg xterm lightdm feh picom rofi firefox-esr alacritty nemo neovim fonts-cantarell unzip wget git make libxcb-xfixes0-dev curl colorpicker xsel imagemagick
        
        sudo apt build-dep awesome
        git clone https://github.com/awesomewm/awesome
        cd awesome
        make package
        cd build
        sudo apt install ./*.deb
        
        cd "$SCRIPTPATH"
        sudo rm -r awesome
        
        sudo mkdir /usr/share/xsessions
        sudo bash -c 'echo "[Desktop Entry]
Name=awesome
Exec=awesome
        " >  /usr/share/xsessions/awesome.desktop'
    ;;
    
    "arch")
        if ! command -v yay &> /dev/null
        then
            echo "yay is not installed. Starting yay installation"
            sudo pacman --noconfirm -S git
            
            cd /opt
            
            sudo git clone https://aur.archlinux.org/yay-git.git
            sudo chown -R $USER ./yay-git
            
            cd yay-git
            makepkg -si
            
            echo "Updating installed packages"
            yay -Syu --noconfirm
            
            echo "Installing dependencies"
            yay -S --noconfirm xorg xterm awesome-git sddm feh picom-git rofi firefox alacritty Adwaita-dark Adwaita nemo neovim cantarell-fonts colorpicker xsel imagemagick
        fi
    ;;
    
    *)
        echo "Not a supported distro. Please use debian or arch"
        exit  1
    ;;
esac


cd "$SCRIPTPATH"

echo "Installing Cascadia Code font"
wget "https://github.com/microsoft/cascadia-code/releases/download/v2111.01/CascadiaCode-2111.01.zip"
unzip CascadiaCode-2111.01.zip -d "Cascadia Code"
sudo mv "Cascadia Code" /usr/share/fonts/
rm CascadiaCode-2111.01.zip

echo "Copying wallpaper"
cp -r dotfiles/.wallpapers ~/

echo "Applying awesomewm configuration"
cp -r dotfiles/.config ~/


# Custom cursor
while true; do
    read -p "Do you wish to use the provided cursor (Bibata-Modern-Ice)? " yn
    case $yn in
        [Yy]* ) cp -r dotfiles/.icons ~/; sudo mkdir /usr/share/cursors; sudo mkdir /usr/share/cursors/xorg-x11; sudo ln -s ~/.icons /usr/share/cursors/xorg-x11/; break;;
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
cp dotfiles/.bashrc ~/
bash -c 'source ~/.bashrc'