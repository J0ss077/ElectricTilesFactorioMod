local custom_implementations = require("scripts.lib.custom-implementations")

local caching_controller = require("scripts.controller.cache-controller")

local network_mapper = require("scripts.unique.network-mapper")

local game_storage = require("scripts.var.game-storage")

local temp_storage = require("scripts.var.temp-storage")

local common_utils = require("scripts.lib.common-utils")

local module = {}

-----------------
-----------------

local subdivisions = { x8 = 8, x16 = 16, x32 = 32 }

local aux_collision_box = { left_top = { x = -0.25, y = -0.25 }, right_bottom = { x = 0.25, y = 0.25 } }

--------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------

--- @param mode "base" | "long"
---
local function process_cached_chunks(mode)
    --
    local cache = game_storage.get(mode .. "-caching-chunks")

    for subdivision_code, subdivision_value in pairs(subdivisions) do
        --
        for chunk_address, v0 in pairs(cache[subdivision_code]) do
            --
            local surface_name, chunk_x, chunk_y = common_utils.chunkData_from_chunkCacheAddress(chunk_address)
            --
            local surface = game.surfaces[surface_name]
            --
            local tiles_matrix = common_utils.generate_square_matrix(2, subdivision_value, 0)
            --
            local chunk_world_area = {
                {
                    chunk_x * subdivision_value,
                    chunk_y * subdivision_value,
                },
                {
                    (chunk_x * subdivision_value) + subdivision_value,
                    (chunk_y * subdivision_value) + subdivision_value,
                },
            }

            --//------------------------------//--
            --//   (1): destroy old proxies   //--
            --//------------------------------//--

            for i0, proxy in ipairs(surface.find_entities_filtered {
                --
                name = temp_storage.get("proxies-names"), area = chunk_world_area
                --
            }) do proxy.destroy() end

            --//-------------------------------//--
            --//   (2): map tiles' positions   //--
            --//-------------------------------//--

            for i0, tile in ipairs(custom_implementations.find_tiles_filtered(surface, {
                --
                name = temp_storage.get("list-allowed-tiles"), area = chunk_world_area
                --
            }, true)) do
                --
                local x = tile.position.x - chunk_world_area[1][1] + 1
                --
                local y = tile.position.y - chunk_world_area[1][2] + 1

                tiles_matrix[x][y] = true
            end

            --//------------------------------//--
            --//   (3): process cubes found   //--
            --//------------------------------//--

            for i0, cube in ipairs(network_mapper.process_matrix(tiles_matrix, subdivision_value, subdivision_value)) do
                --
                --
            end

            caching_controller.clear_chunk(mode, chunk_address, subdivision_code)
        end
    end
end

function module.process_base_cached_chunks() process_cached_chunks("base") end

function module.process_long_cached_chunks() process_cached_chunks("long") end

------------------------------------------------------------------------------
------------------------------------------------------------------------------

--- @param entity LuaEntity
---
function module.update_electric_pole(entity)
    --
    local prototype = entity.prototype

    for i0, proxy_name in ipairs(temp_storage.get("proxies-names")) do
        --
        if prototype.name == proxy_name then return end
        --
    end

    local origin_connector = entity.get_wire_connector(defines.wire_connector_id.pole_copper, false)

    if not origin_connector then return end

    local collision_box = prototype.collision_box or aux_collision_box

    local esurface_area = {
        {
            math.floor(entity.position.x + collision_box.left_top.x),
            math.floor(entity.position.y + collision_box.left_top.y),
        },
        {
            math.ceil(entity.position.x + collision_box.right_bottom.x),
            math.ceil(entity.position.y + collision_box.right_bottom.y),
        },
    }

    if custom_implementations.count_tiles_filtered(entity.surface, { name = temp_storage.get("list-allowed-tiles"), area = esurface_area }, true) == 0 then return end

    local close_proxies = entity.surface.find_entities_filtered {

        name = temp_storage.get("proxies-names"),

        area = {
            {
                esurface_area[1][1] - 32.25,
                esurface_area[1][2] - 32.25,
            },
            {
                esurface_area[2][1] + 32.25,
                esurface_area[2][2] + 32.25,
            },
        }
    }

    if #close_proxies == 0 then return end

    for i0, close_proxy in ipairs(common_utils.find_poles_on_contact_with_area(entity.position, common_utils.convert_BoundingBox_to_Area(collision_box), close_proxies)) do
        --
        local target_connector = close_proxy.get_wire_connector(defines.wire_connector_id.pole_copper, false)
        --
        if target_connector and not origin_connector.is_connected_to(target_connector) then origin_connector.connect_to(target_connector, false) end
    end
end

return module
