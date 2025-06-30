--local data_carrier = prototypes.mod_data["F077ET-data-carrier"]

local update_timer = require("scripts.objects.update-timer")

local tiles_cache = require("scripts.objects.tile-cache")

local temporals = require("scripts.modules.temporals")

local custom_definitions = require("definitions")

-------------------------------------------------

return function(surface_name, old_tiles)
    --
    local lock = false

    for __, old_tile_data in ipairs(old_tiles) do
        --
        --if data_carrier.data["allowed-tiles"][old_tile_data.old_tile.name] then
        if temporals.get("table-allowed-tiles")[old_tile_data.old_tile.name] then
            --
            tiles_cache.cache_tile(surface_name, old_tile_data.position, custom_definitions.tiling_cache_operation.mining)

            if not lock then lock = true end
            --
        end
        --
    end

    if lock then update_timer.restart() end
    --
end
