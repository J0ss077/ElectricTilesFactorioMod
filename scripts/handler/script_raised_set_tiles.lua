local caching_controller = require("scripts.controller.cache-controller")

local common_utils = require("scripts.lib.common-utils")

script.on_event(defines.events.script_raised_set_tiles, function(event_data)
    ---
    for i0, old_data in ipairs(event_data.tiles) do
        --
        caching_controller.cache_chunk("base", game.surfaces[event_data.surface_index].name, common_utils.chunkPosition_from_tilePosition(old_data.position))
        --
    end
    ---
end)
