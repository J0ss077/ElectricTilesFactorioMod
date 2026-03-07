local common_utils = require("scripts.lib.common-utils")

local first_use = false

return function(_data_)
    --
    if not first_use then
        --
        common_utils.debug_inGame("WARNING!! refressing ALL SURFACES consumes a lot of computational power. continue at your own risk", true)

        first_use = true
        --
    else
        --
        remote.call("ElectricTilesControlInterface", "recalculateAllSurfaces")
        --
    end
end
