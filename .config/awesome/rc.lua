local beautiful = require 'beautiful'
-- awesome_mode: api-level=4:screen=on

-- load utility scripts
require 'util'

-- load key and mouse bindings
require 'bindings'

-- load rules
require 'rules'

-- load signals
require 'signals'

-- run autostart applicaitons
require 'startup'


-- load luarocks if installed
pcall(require, 'luarocks.loader')

-- load theme
beautiful.init(script_path() .. 'theme/theme.lua')
