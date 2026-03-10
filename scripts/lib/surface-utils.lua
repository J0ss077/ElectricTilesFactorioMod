local caching_controller = require("scripts.controller.cache-controller")

local common_utils = require("scripts.lib.common-utils")

local temp_storage = require("scripts.var.temp-storage")

local module = {}

--- @param mode "find" | "count"
---
--- @param surface LuaSurface
---
--- @param filter TileSearchFilters
---
--- @param deep? boolean
---
--- @return (LuaTile)[] | integer
---
local function process_tiles_filtered(mode, surface, filter, deep)
    --
    local tiles --- @type (LuaTile)[] | integer

    if mode == "find" then tiles = surface.find_tiles_filtered(filter)
    --
    elseif mode == "count" then tiles = surface.count_tiles_filtered(filter)
    --
    end

    if deep then
        --
        local names = common_utils.convert_array_to_dictionary(filter.name or {}, true)

        local deep_filter = { area = filter.area or nil, has_hidden_tile = true }

        for i0, hidding_tile in ipairs(surface.find_tiles_filtered(deep_filter)) do
            --
            local single_hidden_name = hidding_tile.hidden_tile

            local double_hidden_name = hidding_tile.double_hidden_tile

            if single_hidden_name and names[single_hidden_name] then
                --
                if mode == "find" then table.insert(tiles, { name = single_hidden_name, position = hidding_tile.position, ["F077ET-isSingleHidden"] = true })
                --
                elseif mode == "count" then tiles = tiles + 1; if filter.limit and tiles >= filter.limit then break end
                --
                end
            end

            if double_hidden_name and names[double_hidden_name] then
                --
                if mode == "find" then table.insert(tiles, { name = double_hidden_name, position = hidding_tile.position, ["F077ET-isDoubleHidden"] = true })
                --
                elseif mode == "count" then tiles = tiles + 1; if filter.limit and tiles >= filter.limit then break end
                --
                end
            end
        end
    end

    return tiles
    --
    --
end

--- @param surface LuaSurface
---
--- @param filter TileSearchFilters
---
--- @param deep? boolean
---
--- @return (LuaTile)[]
---
function module.find_tiles_filtered(surface, filter, deep)
    --
    return process_tiles_filtered("find", surface, filter, deep) --- @type (LuaTile)[]
end

--- @param surface LuaSurface
---
--- @param filter TileSearchFilters
---
--- @param deep? boolean
---
--- @return integer
---
function module.count_tiles_filtered(surface, filter, deep)
    --
    return process_tiles_filtered("count", surface, filter, deep) --- @type integer
end

--- @param surface LuaSurface
---
function module.recalculate_surface(surface)
    --
    local chunk_size = temp_storage.get("chunk-area-size")

    local chunk_part = 32 / chunk_size

    ----------------------------------
    ----------------------------------

    for chunk in surface.get_chunks() do
        --
        if surface.is_chunk_generated(chunk) then
            --
            for mult_x = 0, chunk_part - 1, 1 do
                --
                for mult_y = 0, chunk_part - 1, 1 do
                    --
                    local area_x = {

                        (32 * chunk.x) + (mult_x * chunk_size),
                        (32 * chunk.y) + (mult_y * chunk_size),
                    }

                    local area_y = {

                        area_x[1] + chunk_size,
                        area_x[2] + chunk_size,
                    }

                    local count = module.count_tiles_filtered(surface, { name = temp_storage.get("list-allowed-tiles"), area = { area_x, area_y }, limit = 1 }, true)

                    if count > 0 then
                        --
                        caching_controller.cache_chunk("base", surface.name, {

                            x = area_x[1] / chunk_size,
                            y = area_x[2] / chunk_size,
                        })
                        --
                        --
                    end
                end
            end
        end
    end
end

return module
