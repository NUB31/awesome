# NUB31's dotfiles

<div align="center">
    <img src="assets/screenshot.png" width='800px'/>
</div>

## What is included in these dotfiles?

- awesomewm config intended for the latest build as of June 27, 2023
  - On arch btw, install the `awesome-git` instead of the normal `awesome` package
  - On debian and its derivatives, compile the package following the instructions at the [awesome](https://github.com/awesomewm/awesome) repository
- alacritty config
- picom config
- Bibata-Modern-Ice cursor theme
- firewatch-night wallpaper
- .bashrc intended for use with [oh-my-bash](https://github.com/ohmybash/oh-my-bash)

You can of course choose what dotfiles you want to use, but the awesomewm config is the primary focus of this repo. The other configs are intended to compliment the awesomewm config, such as setting the background color or adding transparency.

The `setup.sh` [arch|debian] will install xorg awesomewm, alacritty, picom, feh and other dependencies and copy their matching configs from the dotfiles folder

The script must not be run as a superuser, and your distro has to be passed in as an argument current distros supported are `debian` and `arch`

Example:

```bash
bash setup.sh debian
```

Will download and compile awesome for debian, and then apply the awesomewm config alongside alacritty, picom, feh and other dependencies (see script for a full list),
