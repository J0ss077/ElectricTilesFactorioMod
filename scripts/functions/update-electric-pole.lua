local custom_definitions = require("definitions")

local utilities = require("scripts.modules.utilities")

local temporals = require("scripts.modules.temporals")

------------------------------------------------------

--- @param entity LuaEntity
---
return function(entity) --- poles
    --
    local prototype = entity.prototype

    for __, name in ipairs(temporals.get("proxies-names")) do
        --
        if prototype.name == name then return end
        --
    end

    local chunk_half_area_size = temporals.get("chunk-area-size") / 2

    -------------------------------------------------------------------------------------

    local collision_box = prototype.collision_box or custom_definitions.aux_collision_box

    local tiling_area = {
        {
            math.floor(entity.position.x + collision_box.left_top.x),
            math.floor(entity.position.y + collision_box.left_top.y),
        },
        {
            math.ceil(entity.position.x + collision_box.right_bottom.x),
            math.ceil(entity.position.y + collision_box.right_bottom.y),
        },
    }

    ------------------------------------------------------

    local tiles = utilities.customFindTilesFiltered(entity.surface,

        { name = temporals.get("array-allowed-tiles"), area = tiling_area },

        { deep_search = true }

    ) -- custom implementation

    ----------------------------

    if #tiles == 0 then return end

    local close_proxies = entity.surface.find_entities_filtered {

        name = temporals.get("proxies-names"),

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

    --------------------------------------------------------------------

    local radius = math.abs(math.floor(collision_box.left_top.x)) - 0.25

    for __, close_proxy in ipairs(utilities.getPolesOnContactToPoleLikeArea(entity.position, radius, close_proxies)) do
        --
        local origin = entity.get_wire_connector(defines.wire_connector_id.pole_copper, false)

        if origin == nil then return end -- this pole doesn't have any valid copper connector !!!

        local target = close_proxy.get_wire_connector(defines.wire_connector_id.pole_copper, false)

        if origin.is_connected_to(target) == false then origin.connect_to(target, false) end -- wire
        --
        --
    end
    --
    --
end
