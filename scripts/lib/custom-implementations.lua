local common_utils = require("scripts.lib.common-utils")

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

        local deep_filter = table.deepcopy(filter)

        deep_filter.name = nil

        deep_filter.has_hidden_tile = true

        for i0, hidding_tile in ipairs(surface.find_tiles_filtered(deep_filter)) do
            --
            local single_hidden_name = hidding_tile.hidden_tile

            local double_hidden_name = hidding_tile.double_hidden_tile

            if single_hidden_name and names[single_hidden_name] then
                --
                if mode == "find" then table.insert(tiles, { name = single_hidden_name, position = hidding_tile.position, ["F077ET-isSingleHidden"] = true })
                --
                elseif mode == "count" then tiles = tiles + 1
                --
                end
            end

            if double_hidden_name and names[double_hidden_name] then
                --
                if mode == "find" then table.insert(tiles, { name = double_hidden_name, position = hidding_tile.position, ["F077ET-isDoubleHidden"] = true })
                --
                elseif mode == "count" then tiles = tiles + 1
                --
                end
            end
        end
    end

    return tiles
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

return module
