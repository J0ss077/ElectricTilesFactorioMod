local update_timer = require("scripts.objects.update-timer")

local tiles_cache = require("scripts.objects.tile-cache")

local utilities = require("scripts.modules.utilities")

local temporals = require("scripts.modules.temporals")

local custom_definitions = require("definitions")

return function(_data_)
    --
    utilities.debugInGame("Recalculating all surfaces ... ", true)

    for surface_name, surface_reference in pairs(game.surfaces) do
        --
        for __, tile in ipairs(utilities.customFindTilesFiltered(surface_reference,

            { name = temporals.get("array-allowed-tiles") }, { deep_search = true }

        )) do tiles_cache.cache_tile(surface_name, tile.position, custom_definitions.tiling_cache_operation.undefined) end
        --
    end
    --
    utilities.debugInGame("Surfaces recalculation completed.", true)
    --
    update_timer.restart()
    --
end
