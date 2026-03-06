local network_controller = require("scripts.controller.network-controller")

local temp_storage = require("scripts.var.temp-storage")

local daemon = {}

local tbase_nth_tick = nil

local tlong_nth_tick = nil

--- @param new_time? integer
---
function daemon.reset_base_timer(new_time)
    --
    if tbase_nth_tick then script.on_nth_tick(tbase_nth_tick, nil) end
    --
    tbase_nth_tick = new_time or temp_storage.get("base-update-delay")
    --
    script.on_nth_tick(tbase_nth_tick, network_controller.process_base_cached_chunks)
end

--- @param new_time? integer
---
function daemon.reset_long_timer(new_time)
    --
    if tlong_nth_tick then script.on_nth_tick(tlong_nth_tick, nil) end
    --
    tlong_nth_tick = new_time or temp_storage.get("long-update-delay")
    --
    script.on_nth_tick(tlong_nth_tick, network_controller.process_long_cached_chunks)
end

return daemon
