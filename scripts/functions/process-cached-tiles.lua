local cover_matrix_with_squares_fun = require("scripts.functions.cover-matrix-with-squares")

local utils = require("scripts.modules.utils")

local temps = require("scripts.modules.temps")

local chunk_area_size = temps.get("chunk-area-size")

----------------------------------------------------

return function()
    --
    local everybody = {}

    for x, column in pairs(temps.get("cached-tiles")) do
        --
        for y, data in pairs(column) do
            --
            if data ~= nil then
                --
                local chunk_position = utils.getWorldChunkFromWorldPosition({ x = x, y = y })

                if everybody[data.force.name] == nil then
                    --
                    everybody[data.force.name] = {}
                    --
                end

                if everybody[data.force.name][data.surface.name] == nil then
                    --
                    everybody[data.force.name][data.surface.name] = { surface = data.surface, data = {} }
                    --
                end

                if everybody[data.force.name][data.surface.name].data[chunk_position.x] == nil then
                    --
                    everybody[data.force.name][data.surface.name].data[chunk_position.x] = {}
                    --
                end

                if everybody[data.force.name][data.surface.name].data[chunk_position.x][chunk_position.y] == nil then
                    --
                    everybody[data.force.name][data.surface.name].data[chunk_position.x][chunk_position.y] = true
                    --
                end
                --
            end
            --
        end
        --
    end

    for force_name, force_content in pairs(everybody) do
        --
        for _000_, surface_content in pairs(force_content) do
            --
            for chunk_x, chunk_column in pairs(surface_content.data) do
                --
                for chunk_y, _001_ in pairs(chunk_column) do
                    --
                    local chunk_tiles_matrix = utils.generateEmptyBinarySquareMatrix(chunk_area_size)

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

                    -----------------------------------------------------------------

                    for _002_, proxy in ipairs(surface_content.surface.find_entities_filtered {

                        name = temps.get("proxies-names"), area = chunk_world_bounds, force = force_name,

                    }) do proxy.destroy() end

                    --------------------------------------------------------------------

                    for _002_, tile in ipairs(surface_content.surface.find_tiles_filtered {

                        name = "electric-tile", area = chunk_world_bounds, force = force_name,

                    }) do
                        --
                        chunk_tiles_matrix[tile.position.x - chunk_world_bounds[1][1] + 1][tile.position.y - chunk_world_bounds[1][2] + 1] = true
                        --
                    end

                    --------------------------

                    local minimal_squares = {}

                    for _002_, square in ipairs(cover_matrix_with_squares_fun(chunk_tiles_matrix)) do
                        --
                        local x = square.x * 2 + square.size
                        local y = square.y * 2 + square.size

                        if minimal_squares[x] == nil then minimal_squares[x] = {} end

                        if minimal_squares[x][y] == nil then minimal_squares[x][y] = square.size end
                        --
                    end

                    --------------------------------------------------------

                    for square_x, square_column in pairs(minimal_squares) do
                        --
                        for square_y, square_size in pairs(square_column) do
                            --
                            local proxy_world_position = {

                                x = (square_x / 2) + chunk_world_bounds[1][1] - 1,
                                y = (square_y / 2) + chunk_world_bounds[1][2] - 1,

                            } -- real world positioning for the new proxy

                            local close_proxies = surface_content.surface.find_entities_filtered {

                                name = temps.get("proxies-names"), force = force_name,

                                area = {
                                    {
                                        proxy_world_position.x - chunk_area_size - 0.25,
                                        proxy_world_position.y - chunk_area_size - 0.25,
                                    },
                                    {
                                        proxy_world_position.x + chunk_area_size + 0.25,
                                        proxy_world_position.y + chunk_area_size + 0.25,
                                    },
                                }
                            }

                            local proxy = surface_content.surface.create_entity {

                                name = utils.getProxyNameFromSupplyDistance(square_size / 2),

                                force = force_name, position = proxy_world_position,

                                preserve_ghosts_and_corpses = true

                            } -- spawned proxy reference

                            for _002_, close_proxy in ipairs(utils.getPolesOnContactToPoleLikeArea(proxy.position, square_size / 2, close_proxies)) do
                                --
                                local target_connector = close_proxy.get_wire_connector(defines.wire_connector_id.pole_copper)

                                local origin_connector = proxy.get_wire_connector(defines.wire_connector_id.pole_copper)

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
                    --
                end
                --
            end
            --
        end
        --
    end

    utils.resetTileCache()
    --
end
