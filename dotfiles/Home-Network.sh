#!/bin/sh
VPN_USER="{YOUR_USERNAME_HERE}"
VPN_PASSWORD="{YOUR_PASSWORD_HERE}"
CONFIG_FILE=~/.config/vpn/Home-Network.ovpn

sudo bash -c 'openvpn --config '"$CONFIG_FILE"' --auth-user-pass <(echo -e "'"$VPN_USER"'\n'"$VPN_PASSWORD"'")'
