--- (RUNTIME) ON BUILT/MINED TILE HANDLER

--local data_carrier = prototypes.mod_data["F077ET-data-carrier"]

local update_timer = require("scripts.objects.update-timer")

local tiles_cache = require("scripts.objects.tile-cache")

local temporals = require("scripts.modules.temporals")

local custom_definitions = require("definitions")

return function(surface_name, old_tiles, tile_prototype)
    --
    local locks = false

    local build = false

    if tile_prototype and temporals.get("table-allowed-tiles")[tile_prototype.name] then build = true end

    -----------------------------------------------------------------------------------------------------

    for __, old_tile_data in ipairs(old_tiles) do
        --
        local operation = nil

        if build then -- a build operation will always be more important than mining !!
            --
            operation = custom_definitions.tiling_cache_operation.building
            --
        elseif temporals.get("table-allowed-tiles")[old_tile_data.old_tile.name] then
            --
            operation = custom_definitions.tiling_cache_operation.mining
            --
        end

        if operation then
            --
            tiles_cache.cache_tile(surface_name, old_tile_data.position, operation)

            if not locks then locks = true end
            --
        end
        --
    end

    if locks then update_timer.restart() end
    --
end
