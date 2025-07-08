local update_electric_pole_fun = require("scripts.functions.update-electric-pole")

local cover_with_squares_fun = require("scripts.functions.cover-with-squares")

local tile_cache = require("scripts.objects.tile-cache")

local utilities = require("scripts.modules.utilities")

local temporals = require("scripts.modules.temporals")

return function(_data_)
    --
    local formatted_surfaces = {}

    local chunk_area_size = temporals.get("chunk-area-size")

    for surface_name, surface_content in tile_cache.get_iterator() do
        --
        for x, x_content in pairs(surface_content) do
            --
            for y, tiling_mode in pairs(x_content) do
                --
                if tiling_mode then
                    --
                    local chunk_position = utilities.getWorldChunkFromWorldPosition({ x = x, y = y })

                    if not formatted_surfaces[surface_name] then
                        --
                        formatted_surfaces[surface_name] = {}
                        --
                    end

                    if not formatted_surfaces[surface_name][chunk_position.x] then
                        --
                        formatted_surfaces[surface_name][chunk_position.x] = {}
                        --
                    end

                    if not formatted_surfaces[surface_name][chunk_position.x][chunk_position.y] then
                        --
                        formatted_surfaces[surface_name][chunk_position.x][chunk_position.y] = true
                        --
                    end
                    --
                end
                --
            end
            --
        end
        --
    end

    for surface_name, surface_content in pairs(formatted_surfaces) do
        --
        for chunk_x, chunk_column in pairs(surface_content) do
            --
            for chunk_y, _00_ in pairs(chunk_column) do
                --
                local current_surface = game.surfaces[surface_name]

                local chunk_tiles_matrix = utilities.generateEmptyBinarySquareMatrix(chunk_area_size)

                local chunk_world_bounds = {
                    {
                        chunk_area_size * chunk_x,

                        chunk_area_size * chunk_y,
                    },
                    {
                        chunk_area_size * chunk_x + chunk_area_size,

                        chunk_area_size * chunk_y + chunk_area_size,
                    },
                }

                -------------------------------------------------------------------------------------------------------------------------------------------------------------

                for _01_, proxy in ipairs(current_surface.find_entities_filtered { name = temporals.get("proxies-names"), area = chunk_world_bounds }) do proxy.destroy() end

                -------------------------------------------------------------------------------------------------------------------------------------------------------------

                for _01_, tile in ipairs(utilities.customFindTilesFiltered(current_surface,

                    { name = temporals.get("array-allowed-tiles"), area = chunk_world_bounds }, { deep_search = true }

                )) do chunk_tiles_matrix[tile.position.x - chunk_world_bounds[1][1] + 1][tile.position.y - chunk_world_bounds[1][2] + 1] = 1 end

                --------------------------

                local minimal_squares = {}

                for _01_, square in ipairs(cover_with_squares_fun(chunk_tiles_matrix)) do
                    --
                    local x = square.x * 2 + square.size
                    --
                    local y = square.y * 2 + square.size

                    if minimal_squares[x] == nil then minimal_squares[x] = {} end

                    if minimal_squares[x][y] == nil then minimal_squares[x][y] = square.size end
                    --
                end

                --------------------------

                local spawned_proxies = {}

                for square_x, square_column in pairs(minimal_squares) do
                    --
                    for square_y, square_size in pairs(square_column) do
                        --
                        local proxy_world_position = {

                            x = (square_x / 2) + chunk_world_bounds[1][1] - 1,

                            y = (square_y / 2) + chunk_world_bounds[1][2] - 1,

                        } -- real world positioning for the new proxy

                        local proxy = current_surface.create_entity {

                            raise_built = true, force = "neutral",

                            name = utilities.getProxyNameFromSupplyDistance(square_size / 2),

                            position = proxy_world_position, preserve_ghosts_and_corpses = true

                        } -- spawn reference

                        if proxy ~= nil then
                            --
                            proxy.destructible = false

                            table.insert(spawned_proxies, proxy)
                            --
                        else
                            --
                            utilities.debugInGame("Error while trying to spawn proxy ...")
                            --
                        end
                        --
                    end
                    --
                end

                --------------------------------------------------------------

                local close_proxies = current_surface.find_entities_filtered {

                    name = temporals.get("proxies-names"),

                    area = {
                        {
                            chunk_area_size * chunk_x - (chunk_area_size * 0.5) - 0.25,

                            chunk_area_size * chunk_y - (chunk_area_size * 0.5) - 0.25,
                        },
                        {
                            chunk_area_size * chunk_x + (chunk_area_size * 1.5) + 0.25,

                            chunk_area_size * chunk_y + (chunk_area_size * 1.5) + 0.25,
                        },
                    },
                }

                -----------------------------------------------------

                for _01_, spawned_proxy in ipairs(spawned_proxies) do
                    --
                    local pos = spawned_proxy.position --- world position of proxy

                    local ran = spawned_proxy.prototype.get_supply_area_distance()

                    for _02_, close_proxy in ipairs(utilities.getPolesOnContactToPoleLikeArea(pos, ran, close_proxies)) do
                        --
                        if spawned_proxy ~= close_proxy then
                            --
                            local target_connector = close_proxy.get_wire_connector(defines.wire_connector_id.pole_copper, false)

                            local origin_connector = spawned_proxy.get_wire_connector(defines.wire_connector_id.pole_copper, false)

                            if origin_connector.is_connected_to(target_connector) == false then
                                --
                                origin_connector.connect_to(target_connector, false) -- connect
                                --
                            end
                            --
                        end
                        --
                    end
                    --
                end

                -----------------------------------------------------------------

                for _01_, pole in ipairs(current_surface.find_entities_filtered {

                    type = "electric-pole",

                    area = {
                        {
                            chunk_area_size * chunk_x - 00.25,

                            chunk_area_size * chunk_y - 00.25,
                        },
                        {
                            chunk_area_size * chunk_x + chunk_area_size + 0.25,

                            chunk_area_size * chunk_y + chunk_area_size + 0.25,
                        },
                    },

                }) do update_electric_pole_fun(pole) end
                --
            end
            --
        end
        --
    end

    tile_cache.reset_cache()
    --
end
