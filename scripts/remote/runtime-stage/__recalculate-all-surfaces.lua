local custom_implementations = require("scripts.lib.custom-implementations")

local caching_controller = require("scripts.controller.cache-controller")

local common_utils = require("scripts.lib.common-utils")

local temp_storage = require("scripts.var.temp-storage")

return function(_data_)
    --
    common_utils.debug_inGame("recalculating all surfaces ...", true)

    local chunk_size = temp_storage.get("chunk-area-size")

    local chunk_part = 32 / chunk_size

    ----------------------------------
    ----------------------------------

    for i0, surface in pairs(game.surfaces) do
        --
        for chunk in surface.get_chunks() do
            --
            if surface.is_chunk_generated(chunk) then
                --
                for mult_x = 0, chunk_part - 1, 1 do
                    --
                    for mult_y = 0, chunk_part - 1, 1 do
                        --
                        local area_x = {

                            (32 * chunk.x) + (mult_x * chunk_size),
                            (32 * chunk.y) + (mult_y * chunk_size),
                        }

                        local area_y = {

                            area_x[1] + chunk_size,
                            area_x[2] + chunk_size,
                        }

                        local count = custom_implementations.count_tiles_filtered(surface, { name = temp_storage.get("list-allowed-tiles"), area = { area_x, area_y } }, true)

                        if count > 0 then
                            --
                            caching_controller.cache_chunk("base", surface.name, {

                                x = area_x[1] / chunk_size,
                                y = area_x[2] / chunk_size,
                            })
                            --
                            --
                        end
                    end
                end
            end
        end
    end
end
