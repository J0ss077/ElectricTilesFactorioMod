local network_controller = require("scripts.controller.network-controller")

local daemon = {}

--- @param tick number
---
function daemon.countdown(tick)

    if tick % settings.global["F077ET-base-update-delay"].value == 0 then network_controller.process_base_cached_chunks() end
    if tick % settings.global["F077ET-long-update-delay"].value == 0 then network_controller.process_long_cached_chunks() end

end

return daemon
