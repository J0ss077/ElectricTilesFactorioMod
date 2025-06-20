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
    --
end

return module
