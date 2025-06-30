--local data_carrier = prototypes.mod_data["F077ET-data-carrier"]

local update_timer = require("scripts.objects.update-timer")

local tiles_cache = require("scripts.objects.tile-cache")

local temporals = require("scripts.modules.temporals")

local custom_definitions = require("definitions")

-------------------------------------------------

return function(surface_name, old_tiles, tile_prototype)
    --
    --if not data_carrier.data["allowed-tiles"][tile_prototype.name] then return end
    if not temporals.get("table-allowed-tiles")[tile_prototype.name] then return end

    for __, old_tile_data in ipairs(old_tiles) do -- travel for each pair of builded tiles for caching
        --
        tiles_cache.cache_tile(surface_name, old_tile_data.position, custom_definitions.tiling_cache_operation.building)
        --
    end

    update_timer.restart()
    --
end
