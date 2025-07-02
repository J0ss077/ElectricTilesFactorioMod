local temporals = require("scripts.modules.temporals")

------------------------------------------------------

local module = {}

--- @param distance number
---
--- @return string
---
function module.getProxyNameFromSupplyDistance(distance)
    --
    return "F077ET-proxy-" .. string.format("%03d", math.floor(distance * 2))
    --
end

--- @param position MapPosition
---
--- @return ChunkPosition
---
function module.getWorldChunkFromWorldPosition(position)
    --
    return { x = math.floor(position.x / temporals.get("chunk-area-size")), y = math.floor(position.y / temporals.get("chunk-area-size")) }
    --
end

--- @param message string
---
function module.debugOnLogs(message)
    --
    log(message)
    --
end

--- @param message string
---
--- @param ignore? boolean
---
function module.debugInGame(message, ignore)
    --
    local overwrite = ignore or false

    if not temporals.get("debug-mode") and not overwrite then return end

    game.print("[electric-tiles]: " .. message)
    --
end

--- @param _table_ table
---
--- @param keep_references boolean
---
function module.deleteTableCorrectly(_table_, keep_references)
    --
    for key, ___ in pairs(_table_) do
        --
        if type(_table_[key]) == "table" then
            --
            module.deleteTableCorrectly(_table_[key], keep_references)

            _table_[key] = nil
            --
        elseif not keep_references then
            --
            _table_[key] = nil
            --
        end
        --
    end
    --
end

--- @param _table_ table
---
--- @return table -- all keys
---
function module.getTableKeys(_table_)
    --
    local icount = 00

    local keyset = {}

    for key, ___ in pairs(_table_) do
        --
        icount = icount + 01

        keyset[icount] = key
        --
    end

    return keyset
    --
end

--- @param _table_ table
---
--- @param target any
---
--- @return boolean
---
function module.arrayHasValue(_table_, target)
    --
    for __, value in ipairs(_table_) do
        --
        if value == target then return true end
        --
    end

    return false
    --
end

--- @param target_table table
---
--- @param copied_table table
---
function module.concatArrayTables(target_table, copied_table)
    --
    for i = 1, #copied_table do
        --
        target_table[#target_table + 1] = copied_table[i]
        --
    end
    --
end

--- @param size integer
---
--- @return table
---
function module.generateEmptyBinarySquareMatrix(size)
    --
    local custom_matrix = {}

    for i = 1, size, 1 do
        --
        table.insert(custom_matrix, {}) -- inserts new matrix's rows

        for __ = 1, size, 1 do table.insert(custom_matrix[i], 0) end
        --
    end

    return custom_matrix
    --
end

--- @param world_position MapPosition
---
--- @param range number
---
--- @param pole_entities LuaEntity[]
---
--- @return LuaEntity[]
---
function module.getPolesOnContactToPoleLikeArea(world_position, range, pole_entities)
    --
    local valid_poles = {}

    for __, pole in ipairs(pole_entities) do
        --
        local lock = true

        local expected_distance = range + pole.prototype.get_supply_area_distance()

        if expected_distance < math.abs(world_position.x - pole.position.x) then lock = false end

        if expected_distance < math.abs(world_position.y - pole.position.y) then lock = false end

        if lock then table.insert(valid_poles, pole) end
        --
    end

    return valid_poles
    --
end

--- @param icons_table table
---
--- @param icons_to_add table
---
--- @param inputs table
---
--- @param default_icon_size integer
---
function module.addIconsToIcons(icons_table, icons_to_add, inputs, default_icon_size)
    --
    scale = inputs.scale or 1
    --
    shift = inputs.shift or { 0, 0 }
    --
    tint = inputs.tint or { r = 1, g = 1, b = 1, a = 1 }

    ----------------------------------------------------

    for __, icon_to_add in pairs(icons_to_add) do
        --
        local icon = {}

        icon.icon = icon_to_add.icon

        icon.scale = scale * (icon_to_add.scale or (0.5 * defines.default_icon_size / icon.icon_size))

        icon.icon_size = icon_to_add.icon_size or default_icon_size or error("No icon size defined ...")

        --------------------------------------------------------------------------------------------------

        if icon_to_add.shift then
            --
            icon.shift = { icon_to_add.shift[1] * scale + shift[1], icon_to_add.shift[2] * scale + shift[2] }
            --
        else
            --
            icon.shift = shift
            --
        end

        -----------------------------------------------------------------------------------------------------

        if icon_to_add.tint then icon.tint = util.mix_color(tint, icon_to_add.tint) else icon.tint = tint end

        if icon_to_add.draw_background then icon.draw_background = true end

        table.insert(icons_table, icon)
        --
    end
    --
end

return module
