-- awesome_mode: api-level=4:screen=on
local beautiful = require 'beautiful'

require 'util'
require 'bindings'
require 'signals'
require 'rules'
require 'startup'

-- load theme
beautiful.init(script_path() .. 'theme/theme.lua')
