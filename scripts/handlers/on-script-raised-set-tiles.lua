local update_timer = require("scripts.objects.update-timer")

local tiles_cache = require("scripts.objects.tile-cache")

local custom_definitions = require("definitions")

return function(_data_)
    --
    local surface_name = game.surfaces[_data_.surface_index].name
    --
    for __, tile_data in ipairs(_data_.tiles) do
        --
        tiles_cache.cache_tile(surface_name, tile_data.position, custom_definitions.tiling_cache_operation.undefined)
        --
    end
    --
    update_timer.restart()
    --
end
