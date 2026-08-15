local network_controller = require("scripts.controller.network-controller")

local daemon = {}

local current_base_tick = 0
local current_long_tick = 0

function daemon.countdown_timers()

    current_base_tick = current_base_tick + 1
    current_long_tick = current_long_tick + 1

    if current_base_tick >= settings.global["F077ET-base-update-delay"].value then current_base_tick = 0; network_controller.process_base_cached_chunks() end
    if current_long_tick >= settings.global["F077ET-long-update-delay"].value then current_long_tick = 0; network_controller.process_long_cached_chunks() end
    --
    --
end

return daemon
