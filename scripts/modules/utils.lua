local temps = require("scripts.modules.temps")

local module = {}

function module.getProxyNameFromSupplyDistance(distance)
    --
    return "electric-proxy-" .. string.format("%03d", math.floor(distance * 2))
    --
end

function module.getWorldChunkFromWorldPosition(position)
    --
    return { x = math.floor(position.x / 32), y = math.floor(position.y / 32) }
    --
end

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

function module.countDownUpdateTimer()
    --
    if temps.get("update-timer").enabled == false then return false end

    local forced_predicted_tick = temps.get("forced-timer").tick - 1

    local normal_predicted_tick = temps.get("update-timer").tick - 1

    if normal_predicted_tick > 0 and forced_predicted_tick > 0 then
        --
        temps.get("forced-timer").tick = forced_predicted_tick

        temps.get("update-timer").tick = normal_predicted_tick

        return false
        --
    else
        --
        temps.get("update-timer").enabled = false

        temps.get("forced-timer").enabled = false

        temps.get("update-timer").tick = 0

        temps.get("forced-timer").tick = 0

        if normal_predicted_tick < 0 or forced_predicted_tick < 0 then
            --
            game.print("[electric-tiles-mod][WARNING]: The timer countdown went negatives! Fixing timer ...")

            return false
            --
        else
            --
            return true
            --
        end
        --
    end
    --
end

function module.restartUpdateTimer()
    --
    if temps.get("update-timer").enabled == false then -- timer stopped
        --
        temps.get("update-timer").enabled = true

        temps.get("forced-timer").enabled = true

        temps.get("update-timer").tick = temps.get("update-delay") * 01

        temps.get("forced-timer").tick = temps.get("update-delay") * 10
        --
    else -- timer already running
        --
        temps.get("update-timer").tick = temps.get("update-delay")
        --
    end
    --
end

function module.cacheTile(position, surface, force, add, rem)
    --
    local add_mode = add or false

    local rem_mode = rem or false

    if add_mode == rem_mode then return false end

    ---------------------------------------------

    local cache_info = { mode = 0, surface = surface, force = force }

    -----------------------------------------------------------------

    if temps.get("cached-tiles")[position.x] == nil then temps.get("cached-tiles")[position.x] = {} end

    ---------------------------------------------------------------------------------------------------

    local target = temps.get("cached-tiles")[position.x][position.y]

    if target == nil then
        --
        if add_mode then cache_info.mode = 01 end

        if rem_mode then cache_info.mode = -1 end

        temps.get("cached-tiles")[position.x][position.y] = cache_info
        --
    elseif target.mode > 0 and rem_mode == true then
        --
        temps.get("cached-tiles")[position.x][position.y] = nil
        --
    elseif target.mode < 0 and add_mode == true then
        --
        temps.get("cached-tiles")[position.x][position.y] = nil
        --
    end

    return true
    --
end

function module.resetTileCache()
    --
    temps.set("cached-tiles", {})
    --
end

return module
