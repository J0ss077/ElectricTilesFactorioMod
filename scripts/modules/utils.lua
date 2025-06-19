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

return module
