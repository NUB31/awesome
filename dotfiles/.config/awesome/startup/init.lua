local awful = require('awful')

local cmds =
{
    '~/.screenlayout/layout.sh',
    'feh --bg-fill ~/.wallpapers/bg.jpg',
    'picom',
}

do
    for _, i in pairs(cmds) do
        awful.spawn.with_shell(i)
    end
end
