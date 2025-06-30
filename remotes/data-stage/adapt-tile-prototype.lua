local electric_tile_master_adapter = require("prototypes.electric-tile-master-adapter")

local custom_definitions = require("definitions")

return function(_data_)
    --
    for __, element in ipairs(_data_) do
        --
        if element.tile ~= nil then
            --
            if data.raw.tile[custom_definitions.tile_prefix .. element.tile.name] ~= nil then return false end
            --
        end
        --
        if element.item ~= nil then
            --
            if data.raw.item[custom_definitions.item_prefix .. element.item.name] ~= nil then return false end
            --
        end
        --
        if not electric_tile_master_adapter(element) then return false end
        --
    end
    --
    return true
    --
end
