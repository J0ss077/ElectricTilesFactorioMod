local utilities = require("scripts.modules.utilities")

local second = false

return function(_data_)
    --
    if not second then
        --
        utilities.debugInGame("WARNING: Refreshing all surfaces consumes a lot of computational power, continue at your own risk.", true)

        second = true
        --
    else
        --
        remote.call("ElectricTilesControlInterface", "recalculateAllSurfaces")
        --
    end
    --
end
