local utilities = require("scripts.modules.utilities")

local temporals = require("scripts.modules.temporals")

return function(_data_)
    --
    --local data_carrier = prototypes.mod_data["F077ET-data-carrier"]

    --utilities.debugOnLogs(serpent.block(data_carrier.data)) -- look

    local proxies_names = {}

    local array_allowed_tiles = {}

    ------------------------------

    for i = 0.5, 16.0, 0.5 do
        --
        table.insert(proxies_names, utilities.getProxyNameFromSupplyDistance(i))
        --
    end

    --for name, __ in pairs(data_carrier.data["allowed-tiles"]) do
    --    --
    --    table.insert(array_allowed_tiles, name)
    --    --
    --end

    ---------------------------------------------------------

    temporals.set("array-allowed-tiles", array_allowed_tiles)

    temporals.set("proxies-names", proxies_names)

    temporals.set("table-allowed-tiles", {})
    --
end
