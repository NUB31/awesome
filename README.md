# NUB31's dotfiles

<div align="center">
    <img src="assets/screenshot.png" width='800px'/>
</div>

## What is included in these dotfiles?

- awesomewm config (latest build)
- alacritty config
- picom config
- Bibata-Modern-Ice cursor theme
- Fluent-Compact-Dark gtk Theme
- Fluent-Dark Icon Theme
- firewatch-night wallpaper
- .bashrc intended for use with [oh-my-bash](https://github.com/ohmybash/oh-my-bash)

You can of course choose what dotfiles you want to use, but the awesomewm config is the primary focus of this repo. The other configs are intended to compliment the awesomewm config, such as setting the background color or adding transparency.

The `setup.sh` will install xorg awesomewm, alacritty, picom, feh and other dependencies and copy their matching configs from the dotfiles folder

The script must not be run as a superuser

```bash
sh setup.sh
```

Will download and compile awesome for debian, and then apply the awesomewm config alongside alacritty, picom, feh and other dependencies (see script for a full list),
