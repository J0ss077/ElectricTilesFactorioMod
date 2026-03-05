local caching_controller = require("scripts.controller.cache-controller")

local temp_storage = require("scripts.var.temp-storage")

local common_utils = require("scripts.lib.common-utils")

--- @param event_data EventData.on_player_mined_tile | EventData.on_robot_mined_tile
---
--- @param mode "base" | "long"
---
local function process(event_data, mode)
    --
    for i0, old_data in ipairs(event_data.tiles) do
        --
        if temp_storage.get("dict-allowed-tiles")[old_data.old_tile.name] then
            --
            caching_controller.cache_chunk(

                mode,
                --
                game.surfaces[event_data.surface_index].name,
                --
                common_utils.chunkPosition_from_tilePosition(old_data.position)
            )
        end
    end
end

script.on_event(defines.events.on_player_mined_tile, function(event_data) process(event_data, "base") end)

script.on_event(defines.events.on_robot_mined_tile, function(event_data) process(event_data, "long") end)
