local definitions = require("scripts.var.definitions")
local modder = require("prototypes.modder.tile-modder")

return function(collection)
    --
    for __, base_data in ipairs(collection) do
        --
        local lock = true

        if base_data.tile then
            --
            if data.raw.tile[definitions.tile_prefix .. base_data.tile.name] then lock = false end
        end

        if base_data.item then
            --
            if data.raw.item[definitions.item_prefix .. base_data.item.name] then lock = false end
        end

        if lock then
            --
            modder.make_electric_variant(base_data)
        end
    end
end
