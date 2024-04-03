#!bin/bash
SCRIPT=$(realpath "$0")
SCRIPTPATH=$(dirname "$SCRIPT")

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

function update_packages {
    sudo apt update && sudo apt upgrade -y
}

function install_display_server() {
    sudo apt install -y xorg
}

function install_lightdm() {
    sudo apt install -y lightdm
    sudo systemctl enable lightdm
}

function install_awesome() {
    sudo apt install -y feh picom rofi firefox-esr alacritty nemo imagemagick gpick ffmpeg i3lock scrot pavucontrol nemo libxcb-xfixes0-dev git
    sudo apt-get build-dep -y awesome

    git clone git@github.com:awesomewm/awesome

    cd awesome
    make package
    sudo cp awesome.desktop /usr/share/xsessions/

    cd "$SCRIPTPATH"
    sudo rm -rf awesome-git
    
    mkdir -p ~/.config/
    cp -r dotfiles/* $HOME

    sudo mkdir -p /usr/share/cursors/xorg-x11
    sudo ln -s ~/.icons /usr/share/cursors/xorg-x11/
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

function install_starship() {
    sudo apt install curl
    curl -sS https://starship.rs/install.sh | sh
    echo "eval "$(starship init bash)"" >> "$HOME/.bashrc"
}

function main() {
    if [ "$USER" == "root" ]
    then
        echo "You are currently running as root. Please run this script as a normal user"
        exit
    fi

    update_packages
    install_display_server
    install_lightdm
    install_awesome
    disable_mouse_acceleration
    apply_system_font
    set_cinnamon_default_terminal

    create_select_menu "Do you wish to install oh my starship?" "Yes;No" 0
    case "$?" in
        0) install_starship
    esac
}

main