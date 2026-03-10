local temp_storage = require("scripts.var.temp-storage")

local module = {}

--- @param message string
---
--- @param bypass? boolean
---
function module.debug_inGame(message, bypass)
    --
    bypass = bypass or false

    if (temp_storage.get("debug-mode") or bypass) and game then
        --
        game.print("[electric-tiles]: " .. message)
    end
end

--- @param message string
---
function module.debug_inLogs(message)
    --
    log(message)
end

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

    for i0, value in ipairs(true_adds) do
        --
        table.insert(true_base, value)
    end

    if deepcopy then return true_base end
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

    if deepcopy then return true_base end
end

--- @param array any
---
--- @param value any
---
--- @return table
---
function module.convert_array_to_dictionary(array, value)
    --
    local true_array = (type(array) == "table") and array or { array }

    local dictionary = {}

    for i0, element in ipairs(true_array) do
        --
        dictionary[element] = value or nil
        --
    end

    return dictionary
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
        table.insert(new_icons, {

            scale = 0.5,

            icon = item.icon,

            draw_background = true,

            icon_size = item.icon_size or 64
        })
        --
        --
    end

    item.icons = new_icons

    if clean then
        --
        item.icon = nil
        --
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

--- @param tile_position TilePosition
---
--- @param chunk_area_size? integer
---
--- @return ChunkPosition
---
function module.chunkPosition_from_tilePosition(tile_position, chunk_area_size)
    --
    chunk_area_size = chunk_area_size or temp_storage.get("chunk-area-size")

    return {
        --
        x = math.floor(tile_position.x / chunk_area_size),
        y = math.floor(tile_position.y / chunk_area_size),
    }
end

--- @param surface_name string
---
--- @param chunk_x integer
---
--- @param chunk_y integer
---
--- @return string
---
function module.chunkCacheAddress_from_chunkData(surface_name, chunk_x, chunk_y)
    --
    return string.format("%s/%d/%d", surface_name, chunk_x, chunk_y)
end

--- @param address string
---
--- @return string, integer, integer
---
function module.chunkData_from_chunkCacheAddress(address)
    --
    local surface_name, chunk_x, chunk_y = string.match(address, "^([^/]+)/(%-?%d+)/(%-?%d+)$")
    --
    return surface_name, tonumber(chunk_x, 10), tonumber(chunk_y, 10)
end

--- @param box BoundingBox
---
--- @return table
---
function module.convert_BoundingBox_to_Area(box)
    --
    return { { box.left_top.x, box.left_top.y }, { box.right_bottom.x, box.right_bottom.y } }
end

--- @param dimension integer
---
--- @param length integer
---
--- @param value? any
---
--- @return table
---
function module.generate_square_matrix(dimension, length, value)
    --
    local matrix = {}

    for index = 1, length do
        --
        if dimension > 1 then matrix[index] = module.generate_square_matrix(dimension - 1, length, value)
        --
        else matrix[index] = value end
        --
    end

    return matrix
    --
    --
end

--- @param position MapPosition
---
--- @param area BoundingBox
---
--- @param poles (LuaEntity)[]
---
--- @return (LuaEntity)[]
---
function module.find_poles_on_contact_with_area(position, area, poles)
    --
    local valid_poles = {}

    for i0, pole in ipairs(poles) do
        --
        local supply_distance = pole.prototype.get_supply_area_distance()

        if
            (pole.position.x + supply_distance >= position.x + area[1][1]) and
            (pole.position.x - supply_distance <= position.x + area[2][1]) and
            (pole.position.y + supply_distance >= position.y + area[1][2]) and
            (pole.position.y - supply_distance <= position.y + area[2][2])
        then
            --
            table.insert(valid_poles, pole)
            --
        end
    end

    return valid_poles
    --
    --
end

--- @param pole01 LuaEntity
---
--- @param pole02 LuaEntity
---
--- @param force? boolean
---
--- @param wire_type? any
---
function module.connect_poles(pole01, pole02, force, wire_type)
    --
    wire_type = wire_type or defines.wire_connector_id.pole_copper
    --
    force = force or false

    local origin_connector = pole01.get_wire_connector(wire_type, force)

    local target_connector = pole02.get_wire_connector(wire_type, force)

    if origin_connector and target_connector and not origin_connector.is_connected_to(target_connector) then
        --
        origin_connector.connect_to(target_connector, not force)
        --
    end
end

return module
