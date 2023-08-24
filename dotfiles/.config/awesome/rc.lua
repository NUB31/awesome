-- awesome_mode: api-level=4:screen=on
local beautiful = require 'beautiful'
local script_path = require 'util.script_path'

require 'bindings'
require 'signals'
require 'rules'
require 'startup'

-- load theme
beautiful.init(script_path() .. 'theme/theme.lua')
