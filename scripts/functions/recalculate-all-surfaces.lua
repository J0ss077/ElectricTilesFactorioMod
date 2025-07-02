local update_timer = require("scripts.objects.update-timer")

local tiles_cache = require("scripts.objects.tile-cache")

local utilities = require("scripts.modules.utilities")

local temporals = require("scripts.modules.temporals")

local custom_definitions = require("definitions")

return function(_data_)
    --
    utilities.debugInGame("Recalculating all surfaces ...", true)

    for surface_name, surface_reference in pairs(game.surfaces) do
        --
        for __, tile in ipairs(surface_reference.find_tiles_filtered { name = temporals.get("array-allowed-tiles") }) do
            --
            tiles_cache.cache_tile(surface_name, tile.position, custom_definitions.tiling_cache_operation.undefined)
            --
        end
        --
    end
    --
    utilities.debugInGame("Surfaces recalculation completed.", true)
    --
    update_timer.restart()
    --
end
