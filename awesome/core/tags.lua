local capi = Capi
local ipairs = ipairs
local awful = require("awful")
local gtable = require("gears.table")

local tags = {
    default_tags = {
        "Home",
        "Browser",
        "Dev",
    },
}

function tags.build_tag(args)
    return gtable.crush({
        layout = awful.layout.layouts[1],
        gap_single_client = false,
        master_fill_policy = "master_width_factor",
        master_width_factor = 0.6,
    }, args or {})
end

function tags.add_volatile_tag(screen, name)
    name = name or tostring(1 + (#screen.tags or 0))
    local tag = awful.tag.add(name, tags.build_tag {
        screen = screen,
        volatile = true,
        visited = false,
    })
    return tag
end

capi.screen.connect_signal("request::desktop_decoration",
    function(screen)
        for i = 1, 3 do
            awful.tag.add(tags.default_tags[i], tags.build_tag {
                screen = screen,
                selected = i == 1,
            })
        end
    end
)

capi.screen.connect_signal("tag::history::update",
    function(screen)
        for _, tag in ipairs(screen.tags) do
            if tag.selected then
                tag.visited = true
            elseif tag.volatile and tag.visited and #tag:clients() == 0 then
                tag:delete()
            end
        end
    end
)

return tags
