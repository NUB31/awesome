function log(message)
    local naughty = require 'naughty'
    naughty.notification {
        title = 'Log',
        message = message
    }
end

return log
