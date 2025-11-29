local temp_storage = require("scripts.var.temp-storage")

local module = {}

--- @param base table
---
--- @param adds table
---
--- @param deepcopy? boolean
---
function module.combine_arrays(base, adds, deepcopy)
    --
    deepcopy = deepcopy or false

    local true_base = deepcopy and table.deepcopy(base) or base
    local true_adds = deepcopy and table.deepcopy(adds) or adds

    for __, value in ipairs(true_adds) do
        --
        table.insert(true_base, value)
    end

    if deepcopy then
        --
        return true_base
    end
end

--- @param base table
---
--- @param adds table
---
--- @param deepcopy? boolean
---
function module.combine_dictionaries(base, adds, deepcopy)
    --
    deepcopy = deepcopy or false

    local true_base = deepcopy and table.deepcopy(base) or base
    local true_adds = deepcopy and table.deepcopy(adds) or adds

    for key, value in pairs(true_adds) do
        --
        true_base[key] = value
    end

    if deepcopy then
        --
        return true_base
    end
end

--- @param item table
---
--- @param clean? boolean
---
function module.parse_item_icons(item, clean)
    --
    clean = clean or false

    local new_icons = {}

    if item.icons then
        --
        new_icons = table.deepcopy(item.icons)
        --
    elseif item.icon then
        --
        table.insert(new_icons, { scale = 0.5, icon = item.icon, draw_background = true, icon_size = item.icon_size or 64 })
    end

    item.icons = new_icons

    if clean then
        --
        item.icon = nil
        item.icon_size = nil
    end
end

--- @param supply_distance number
---
--- @return string
---
function module.proxyName_from_supplyDistance(supply_distance)
    --
    return "F077ET-proxy-" .. string.format("%03d", math.floor(supply_distance * 2))
end

--- @param tile_position MapPosition
---
--- @return ChunkPosition
---
function module.chunkPosition_from_tilePosition(tile_position)
    --
    return {
        --
        x = math.floor(tile_position.x / temp_storage.get("chunk-area-size")),
        y = math.floor(tile_position.y / temp_storage.get("chunk-area-size")),
    }
end

return module
