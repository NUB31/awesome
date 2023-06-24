function log(message)
    local naughty = require 'naughty'
    naughty.notification {
        title = 'Test',
        message = message
    }
end
