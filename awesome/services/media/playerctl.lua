-- DEPENDENCIES: playerctl

local type = type
local pairs = pairs
local ipairs = ipairs
local gobject = require("gears.object")
local gtable = require("gears.table")
local gtimer = require("gears.timer")
local lgi_playerctl = require("lgi").Playerctl

local playerctl = {
    lowest_priority = math.maxinteger,
    any = { name = "%any" },
    all = { name = "%all" },
}

playerctl.object = { second = 1000000 }

function playerctl.object:get_position_data(player_data)
    player_data = player_data or self.primary_player_data
    return (player_data and player_data.metadata) and {
        position = player_data.position,
        length = player_data.metadata.length,
    }
end

local function find_player_by_instance(self, instance)
    for _, player in ipairs(self.manager.players) do
        if player.player_instance == instance then
            return player
        end
    end
end

local function for_each_player(self, player_selector, action)
    local players
    if not player_selector then
        local player_data = self.primary_player_data
        if player_data then
            players = { find_player_by_instance(self, player_data.instance) }
        end
    elseif player_selector == playerctl.all.name then
        players = self.manager.players
    elseif type(player_selector) == "string" then
        players = { find_player_by_instance(self, player_selector) }
    end

    if players then
        for _, p in ipairs(players) do
            action(p)
        end
    end
end

function playerctl.object:play_pause(player_selector)
    for_each_player(self, player_selector, function(p)
        p:play_pause()
    end)
end

function playerctl.object:play(player_selector)
    for_each_player(self, player_selector, function(p)
        p:play()
    end)
end

function playerctl.object:pause(player_selector)
    for_each_player(self, player_selector, function(p)
        p:pause()
    end)
end

function playerctl.object:stop(player_selector)
    for_each_player(self, player_selector, function(p)
        p:stop()
    end)
end

function playerctl.object:previous(player_selector)
    for_each_player(self, player_selector, function(p)
        p:previous()
    end)
end

function playerctl.object:next(player_selector)
    for_each_player(self, player_selector, function(p)
        p:next()
    end)
end

function playerctl.object:skip(offset, player_selector)
    if offset > 0 then
        self:next(player_selector)
    else
        self:previous(player_selector)
    end
end

function playerctl.object:rewind(offset, player_selector)
    self:seek(-offset, player_selector)
end

function playerctl.object:fast_forward(offset, player_selector)
    self:seek(offset, player_selector)
end

function playerctl.object:seek(offset, player_selector)
    for_each_player(self, player_selector, function(p)
        p:seek(offset)
    end)
end

function playerctl.object:set_loop_status(loop_status, player_selector)
    loop_status = loop_status:upper()
    for_each_player(self, player_selector, function(p)
        p:set_loop_status(loop_status)
    end)
end

function playerctl.object:cycle_loop_status(player_selector)
    for_each_player(self, player_selector, function(p)
        if p.loop_status == "NONE" then
            p:set_loop_status("TRACK")
        elseif p.loop_status == "TRACK" then
            p:set_loop_status("PLAYLIST")
        elseif p.loop_status == "PLAYLIST" then
            p:set_loop_status("NONE")
        end
    end)
end

function playerctl.object:set_position(position, player_selector)
    for_each_player(self, player_selector, function(p)
        p:set_position(position)
    end)
end

function playerctl.object:set_shuffle(shuffle, player_selector)
    for_each_player(self, player_selector, function(p)
        p:set_shuffle(shuffle)
    end)
end

function playerctl.object:toggle_shuffle(player_selector)
    for_each_player(self, player_selector, function(p)
        p:set_shuffle(not p.shuffle)
    end)
end

function playerctl.object:set_volume(volume, player_selector)
    for_each_player(self, player_selector, function(p)
        p:set_volume(volume)
    end)
end

function playerctl.object:is_primary_player(player_data)
    return self.primary_player_data == player_data
end

function playerctl.object:get_primary_player_data()
    return self.primary_player_data
end

local function update_primary_player(self, player)
    if player then
        self.manager:move_player_to_top(player)
    end

    local primary_player = self.manager.players[1]

    local old = self.primary_player_data
    local new = self.player_data[primary_player and primary_player.player_instance]
    if old ~= new then
        self.primary_player_data = new
        self:emit_signal("media::player::primary", new, old)
    end
end

function playerctl.object:is_pinned(player_data)
    local player_name = player_data and player_data.name or nil
    return self.pinned_player_name == player_name
end

function playerctl.object:pin(player_data)
    local player_name = player_data and player_data.name or nil
    if self.pinned_player_name ~= player_name then
        self.pinned_player_name = player_name
        self:emit_signal("media::player::pinned", self.pinned_player_name)

        local player
        if player_data then
            player = find_player_by_instance(self, player_data.instance)
        elseif self.primary_player_data then
            player = find_player_by_instance(self, self.primary_player_data.instance)
        end

        update_primary_player(self, player)
    end
end

local function refresh_position_timer(player_data)
    if player_data.playback_status == "PLAYING" then
        player_data._position_timer:again()
    else
        player_data._position_timer:stop()
    end
end

local function update_position(self, player_data, by_timer)
    local player = find_player_by_instance(self, player_data.instance)
    if player then
        player_data.position = player:get_position()
        self:emit_signal("media::player::position", player_data, by_timer)
    end
end

local function update_metadata(self, player_data, metadata)
    metadata = metadata and metadata.value or {}

    local changed = false
    local changed_data = {}

    local function mark_changed(name)
        changed = true
        changed_data[name] = true
    end

    local target_metadata = player_data.metadata
    for name, mpris_name in pairs(self.tracked_metadata) do
        local value = metadata[mpris_name]
        local value_type = type(value)
        if value_type == "nil" or value_type == "boolean" or value_type == "number" or value_type == "string" then
            if target_metadata[name] ~= value then
                target_metadata[name] = value
                mark_changed(name)
            end
        elseif value_type == "userdata" and value.type == "as" then
            local old = target_metadata[name]
            if type(old) ~= "table" then
                old = {}
            end

            local new = {}
            for _, s in value:ipairs() do
                new[#new + 1] = s
            end

            target_metadata[name] = new

            if #old ~= #new then
                mark_changed(name)
            else
                for i = 1, #new do
                    if old[i] ~= new[i] then
                        mark_changed(name)
                        break
                    end
                end
            end
        else
            if target_metadata[name] ~= nil then
                target_metadata[name] = nil
                mark_changed(name)
            end
        end
    end

    return changed, changed_data
end

local function manage_player(self, full_name)
    local new_player = lgi_playerctl.Player.new_from_name(full_name)

    function new_player.on_metadata(p, metadata)
        local player_data = self.player_data[p.player_instance]
        if player_data and update_metadata(self, player_data, metadata) then
            self:emit_signal("media::player::metadata", player_data)

            update_position(self, player_data)
            refresh_position_timer(player_data)
        end
    end

    function new_player.on_playback_status(p, playback_status)
        update_primary_player(self, p)

        local player_data = self.player_data[p.player_instance]
        if player_data and player_data.playback_status ~= playback_status then
            player_data.playback_status = playback_status
            self:emit_signal("media::player::playback_status", player_data)

            update_position(self, player_data)
            refresh_position_timer(player_data)
        end
    end

    function new_player.on_seeked(p, position)
        local player_data = self.player_data[p.player_instance]
        if player_data and player_data.position ~= position then
            player_data.position = position
            self:emit_signal("media::player::position", player_data)

            refresh_position_timer(player_data)
        end
    end

    function new_player.on_shuffle(p, shuffle)
        local player_data = self.player_data[p.player_instance]
        if player_data and player_data.shuffle ~= shuffle then
            player_data.shuffle = shuffle
            self:emit_signal("media::player::shuffle", player_data)
        end
    end

    function new_player.on_loop_status(p, loop_status)
        local player_data = self.player_data[p.player_instance]
        if player_data and player_data.loop_status ~= loop_status then
            player_data.loop_status = loop_status
            self:emit_signal("media::player::loop_status", player_data)
        end
    end

    function new_player.on_volume(p, volume)
        local player_data = self.player_data[p.player_instance]
        if player_data and player_data.volume ~= volume then
            player_data.volume = volume
            self:emit_signal("media::player::volume", player_data)
        end
    end

    self.manager:manage_player(new_player)

    return new_player
end

local function filter_name(self, player_name)
    if self.excluded_players[player_name] then
        return false
    end
    if self.player_priorities[playerctl.any] or self.player_priorities[player_name] then
        return true
    end
    return false
end

local function compare_players(self, player_a, player_b)
    local pinned_a = self.pinned_player_name == player_a.player_name and 0 or 1
    local pinned_b = self.pinned_player_name == player_b.player_name and 0 or 1
    if pinned_a ~= pinned_b then
        return pinned_a - pinned_b
    end

    local playing_a = player_a.playback_status == "PLAYING" and 0 or 1
    local playing_b = player_b.playback_status == "PLAYING" and 0 or 1
    if playing_a ~= playing_b then
        return playing_a - playing_b
    end

    local priorities = self.player_priorities
    local priority_a = priorities[player_a.player_name] or priorities[playerctl.any] or playerctl.lowest_priority
    local priority_b = priorities[player_b.player_name] or priorities[playerctl.any] or playerctl.lowest_priority
    return priority_a - priority_b
end

local function initialize_manager(self)
    self.player_data = {}

    self.manager = lgi_playerctl.PlayerManager()
    self.manager:set_sort_func(function(a, b)
        local player_a = lgi_playerctl.Player(a)
        local player_b = lgi_playerctl.Player(b)
        return compare_players(self, player_a, player_b)
    end)

    local function try_manage(full_name)
        if filter_name(self, full_name.name) then
            return manage_player(self, full_name)
        end
    end

    function self.manager.on_name_appeared(_, full_name)
        try_manage(full_name)
    end

    function self.manager.on_player_appeared(_, player)
        local player_data = {
            name = player.player_name,
            instance = player.player_instance,
            playback_status = player.playback_status,
            position = player.position,
            shuffle = player.shuffle,
            loop_status = player.loop_status,
            volume = player.volume,
            metadata = {},
        }
        update_metadata(self, player_data, player.metadata)

        player_data._position_timer = gtimer {
            timeout = 1,
            callback = function()
                update_position(self, player_data, true)
            end,
        }
        refresh_position_timer(player_data)

        self.player_data[player_data.instance] = player_data
        self:emit_signal("media::player::appeared", player_data)

        update_primary_player(self, player)
    end

    function self.manager.on_player_vanished(_, player)
        update_primary_player(self)

        local player_data = assert(self.player_data[player.player_instance])

        player_data._position_timer:stop()

        self:emit_signal("media::player::vanished", player_data)
        self.player_data[player.player_instance] = nil
    end

    for _, full_name in ipairs(self.manager.player_names) do
        try_manage(full_name)
    end

    update_primary_player(self)
end

local function parse_args(self, args)
    args = args or {}

    self.tracked_metadata = args.metadata or {}

    -- Always track length
    self.tracked_metadata.length = "mpris:length"

    local excluded_players = {}
    if type(args.excluded_players) == "string" then
        excluded_players[args.excluded_players] = true
    elseif args.excluded_players then
        for _, name in ipairs(args.excluded_players) do
            excluded_players[name] = true
        end
    end
    self.excluded_players = excluded_players

    local function get_priority_key(name)
        return name == playerctl.any.name and playerctl.any or name
    end
    local player_priorities
    if type(args.players) == "string" then
        player_priorities = { [get_priority_key(args.players)] = 1 }
    elseif type(args.players) == "table" and #args.players > 0 then
        player_priorities = {}
        for i, name in ipairs(args.players) do
            player_priorities[get_priority_key(name)] = i
        end
    else
        player_priorities = { [playerctl.any] = 1 }
    end
    self.player_priorities = player_priorities
end

function playerctl.new(args)
    local self = gtable.crush(gobject {}, playerctl.object, true)

    parse_args(self, args)

    initialize_manager(self)

    return self
end

return playerctl
