local _M = {
   terminal     = 'alacritty',
   editor       = 'nvim',
   file_browser = "nemo",
   web_browser  = "firefox",
   code         = "code",
   run          = "rofi options -theme Monokai -show drun",
   windows      = "rofi options -theme Monokai -show window",
   color_picker = "colorpicker --short --one-shot | xsel -b",
}

_M.editor_cmd = _M.terminal .. ' -e ' .. _M.editor
_M.manual_cmd = _M.terminal .. ' -e man awesome'

_M.screenshot = function(name)
   os.execute("mkdir -p " .. "~/Screenshots")
   return "import ~/Screenshots/" .. name .. ".png"
end

return _M
