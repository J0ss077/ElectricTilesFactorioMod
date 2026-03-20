local caching_controller = require("scripts.controller.cache-controller")

local temp_storage = require("scripts.var.temp-storage")

local common_utils = require("scripts.lib.common-utils")

script.on_event(defines.events.script_raised_destroy, function(event_data)
    -----
    -----
    local surface = event_data.entity.surface

    local position = event_data.entity.position

    local tile = surface.get_tile(position.x, position.y)

    if tile and temp_storage.get("dict-allowed-tiles")[tile.name] then
        --
        caching_controller.cache_chunk("base", surface.name, common_utils.chunkPosition_from_tilePosition(position))
        --
    end
    ---
    ---
end, { { filter = "type", type = "deconstructible-tile-proxy" } })
