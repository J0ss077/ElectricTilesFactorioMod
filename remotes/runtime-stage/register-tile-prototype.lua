local temporals = require("scripts.modules.temporals")

local custom_definitions = require("definitions")

return function(_data_)
    --
    for __, element in ipairs(_data_) do
        --
        local name = custom_definitions.tile_prefix .. element
        --
        if prototypes.tile[name] == nil then return false end
        --
        if not temporals.get("table-allowed-tiles")[name] then
            --
            table.insert(temporals.get("array-allowed-tiles"), name)
            --
            temporals.get("table-allowed-tiles")[name] = true -- save
            --
        end
        --
    end
    --
    return true
    --
end
