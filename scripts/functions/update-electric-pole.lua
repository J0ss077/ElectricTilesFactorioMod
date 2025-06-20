local utils = require("scripts.modules.utils")

local temps = require("scripts.modules.temps")

local chunk_half_area_size = temps.get("chunk-area-size") / 2

-------------------------------------------------------------

return function(entity)
    --
    local prototype = entity.prototype

    for __, name in ipairs(temps.get("proxies-names")) do
        --
        if prototype.name == name then return end
        --
    end

    local aux_collision_box = prototype.collision_box or temps.get("aux-collision-box")

    local tiling_area = {
        {
            math.floor(entity.position.x + aux_collision_box.left_top.x),
            math.floor(entity.position.y + aux_collision_box.left_top.y),
        },
        {
            math.ceil(entity.position.x + aux_collision_box.right_bottom.x),
            math.ceil(entity.position.y + aux_collision_box.right_bottom.y),
        },
    }

    local tiles = entity.surface.find_tiles_filtered {

        force = entity.force.name,

        name = "electric-tile",

        area = tiling_area
    }

    if #tiles == 0 then return end

    local close_proxies = entity.surface.find_entities_filtered {

        name = temps.get("proxies-names"), force = entity.force.name,

        area = {
            {
                entity.position.x - chunk_half_area_size - 0.25,
                entity.position.y - chunk_half_area_size - 0.25,
            },
            {
                entity.position.x + chunk_half_area_size + 0.25,
                entity.position.y + chunk_half_area_size + 0.25,
            },
        }
    }

    if #close_proxies == 0 then return end

    ------------------------------------------------------------------------

    local radius = math.abs(math.floor(aux_collision_box.left_top.x)) - 0.25

    for __, close_proxy in ipairs(utils.getPolesOnContactToPoleLikeArea(entity.position, radius, close_proxies)) do
        --
        local origin = entity.get_wire_connector(defines.wire_connector_id.pole_copper)

        if origin == nil then return end -- the pole doesn't have a valid copper connector

        local target = close_proxy.get_wire_connector(defines.wire_connector_id.pole_copper)

        if origin.is_connected_to(target) == false then origin.connect_to(target, false) end
        --
        --
    end
    --
    --
end
