#!bin/bash
SCRIPT=$(realpath "$0")
SCRIPTPATH=$(dirname "$SCRIPT")
LOGFILE="$SCRIPTPATH/log.txt"

function print_select_menu() {
    local function_arguments=($@)
    
    local selected_item="$1"
    local menu_items=(${function_arguments[@]:1})
    local menu_size="${#menu_items[@]}"
    
    for (( i = 0; i < $menu_size; ++i ))
    do
        if [ "$i" = "$selected_item" ]
        then
            echo "-> ${menu_items[i]}"
        else
            echo "   ${menu_items[i]}"
        fi
    done
}

function create_select_menu() {
    local prompt="$1"

    local menu_items_arg="$2"
    IFS=';' read -ra menu_items <<< "$menu_items_arg"

    local menu_size="${#menu_items[@]}"
    local menu_limit=$((menu_size - 1))
    
    local selected_item="$3"
    
    clear
    echo "$prompt"
    print_select_menu "$selected_item" "${menu_items[@]}"
    
    while read -rsn1 input
    do
        case "$input"
            in
            $'\x1B')  # ESC ASCII code (https://dirask.com/posts/ASCII-Table-pJ3Y0j)
                read -rsn1 -t 0.1 input
                if [ "$input" = "[" ]  # occurs before arrow code
                then
                    read -rsn1 -t 0.1 input
                    case "$input"
                        in
                        A)  # Up Arrow
                            if [ "$selected_item" -ge 1 ]
                            then
                                selected_item=$((selected_item - 1))
                                clear
                                echo "$prompt"
                                print_select_menu "$selected_item" "${menu_items[@]}"
                            fi
                        ;;
                        B)  # Down Arrow
                            if [ "$selected_item" -lt "$menu_limit" ]
                            then
                                selected_item=$((selected_item + 1))
                                clear
                                echo "$prompt"
                                print_select_menu "$selected_item" "${menu_items[@]}"
                            fi
                        ;;
                    esac
                fi
                read -rsn5 -t 0.1  # flushing stdin
            ;;
            "")  # Enter key
                return "$selected_item"
            ;;
        esac
    done
}

function arch_update_packages {
    sudo pacman -Syu --noconfirm
}

function arch_install_display_server() {
    sudo pacman -S --noconfirm xorg
}

function arch_install_lightdm() {
    sudo pacman -S --noconfirm lightdm lightdm-gtk-greeter
    sudo systemctl enable lightdm
}

function arch_install_sddm() {
    sudo pacman -S --noconfirm sddm
    sudo systemctl enable sddm
}

function arch_install_awesome() {
    sudo pacman -S --noconfirm feh picom rofi firefox alacritty nemo neovim cantarell-fonts otf-cascadia-code imagemagick xsel
    
    cd "$SCRIPTPATH"
    sudo pacman -S --noconfirm --needed base-devel git
    git clone https://aur.archlinux.org/awesome-git.git
    cd awesome-git
    makepkg -fsri --noconfirm
    
    cd "$SCRIPTPATH"
    sudo rm -r awesome-git

    mkdir -p ~/.config/
    cp -r dotfiles/.config/awesome ~/.config
    cp -r dotfiles/.config/alacritty ~/.config
    cp -r "dotfiles/.config/Code OSS" ~/.config
    cp -r dotfiles/.config/picom ~/.config
    cp -r dotfiles/.config/vpn ~/.config

    cp -r dotfiles/.icons ~/
    sudo mkdir -p /usr/share/cursors/xorg-x11
    sudo ln -s ~/.icons /usr/share/cursors/xorg-x11/
    
    cp -r dotfiles/.themes ~/

    mkdir -p ~/.local/share/icons
    cp -r dotfiles/.local/share/icons/Fluent-Dark ~/.local/share/icons

    mkdir -p ~/.config
    cp -r dotfiles/.config/gtk-3.0 ~/.config
}

function arch_install_yay() {
    sudo pacman --noconfirm -S git

    cd /opt

    sudo git clone https://aur.archlinux.org/yay-git.git
    sudo chown -R $USER ./yay-git

    cd yay-git
    makepkg -si
}

function disable_mouse_acceleration() {
    sudo bash -c "echo 'Section \"InputClass\" Identifier \"My Mouse\" Driver \"libinput\" MatchIsPointer \"yes\" Option \"AccelProfile\" \"flat\" EndSection' > /etc/X11/xorg.conf.d/50-mouse-acceleration.conf"
}

function apply_system_font() {
    echo 'gtk-font-name="Cantarell 11"' >> ~/.config/.gtkrc-2.0
    sudo bash -c "echo 'Section \"Files\" FontPath \"/usr/share/fonts/cantarell/\" EndSection' > /etc/X11/xorg.conf.d/10-fonts.conf"
}

function set_cinnamon_default_terminal() {
    gsettings set org.cinnamon.desktop.default-applications.terminal exec alacritty
}

function install_oh_my_bash() {
    bash -c "$(curl -fsSL https://raw.githubusercontent.com/ohmybash/oh-my-bash/master/tools/install.sh)"
    cp dotfiles/.bashrc ~/
    bash -c 'source ~/.bashrc'
}


function main() {
    rm "$LOGFILE" 2> /dev/null
    
    if [ "$USER" == "root" ]
    then
        echo "You are currently running as root. Please run this script as a normal user"
        exit
    fi

    arch_update_packages >> "$LOGFILE"
    arch_install_display_server >> "$LOGFILE"

    create_select_menu "What display manager do you want to use?" "LightDM;SDDM" 0
    case "$?" in
        0) arch_install_lightdm >> "$LOGFILE";;
        1) arch_install_sddm >> "$LOGFILE";;
    esac

    arch_install_awesome >> "$LOGFILE"

    create_select_menu "Do you wish to disable mouse acceleration?" "Yes;No" 0
    case "$?" in
        0) disable_mouse_acceleration >> "$LOGFILE";;
    esac

    apply_system_font >> "$LOGFILE"
    set_cinnamon_default_terminal >> "$LOGFILE"

    create_select_menu "Do you wish to install yay?" "Yes;No" 0
    case "$?" in
        0) install_yay >> "$LOGFILE";;
    esac

    create_select_menu "Do you wish to install oh my bash?" "Yes;No" 0
    case "$?" in
        0) install_oh_my_bash >> "$LOGFILE";;
    esac
}
main