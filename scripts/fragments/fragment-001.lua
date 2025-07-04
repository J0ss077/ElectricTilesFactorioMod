--- (RUNTIME) REGISTER TILES' PROTOTYPES

local utilities = require("scripts.modules.utilities")

return function(_data_)
    --
    local names = {
        --
        "stone-path",
        --
        "concrete",
        --
        "hazard-concrete-left",
        --
        "hazard-concrete-right",
        --
        "refined-concrete",
        --
        "refined-hazard-concrete-left",
        --
        "refined-hazard-concrete-right",
        --
    }
    --
    if script.active_mods["space-age"] then
        --
        local new_names = {}
        --
        for __, name in ipairs(names) do
            --
            table.insert(new_names, "frozen-" .. name)
            --
        end
        --
        utilities.concatArrayTables(names, new_names)
        --
    end
    --
    remote.call("ElectricTilesControlInterface", "registerTilePrototype", names)
    --
end
