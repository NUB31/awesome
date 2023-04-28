local awful = require("awful")

require("develop")

require("globals")

require("config")

require("theme.manager").initialize()

require("core")
require("services")
require("ui")

---@diagnostic disable: param-type-mismatch
collectgarbage("setpause", 110)
collectgarbage("setstepmul", 1000)
---@diagnostic enable: param-type-mismatch

do
    local cmds =
    {
      "nitrogen --restore",
      "picom",
      "sh ~/.screenlayout/layout.sh",
      "xsetroot -Cutefish-Light left_ptr",
      "xinput --set-prop 12 'libinput Accel Speed' 0",
      "[[ -f ~/.Xresources ]] && xrdb -merge ~/.Xresources"
    }
  
    for _,i in pairs(cmds) do
      awful.util.spawn(i)
    end
  end
  
