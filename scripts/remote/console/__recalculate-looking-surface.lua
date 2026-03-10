local common_utils = require("scripts.lib.common-utils")

local first_use = false

return function(event_data)
    --
    if not first_use then
        --
        common_utils.debug_inGame("WARNING!! refressing a surface consumes a good amount of computational power. continue at your own risk", true)
        --
        first_use = true
        --
    elseif event_data.player_index then
        --
        remote.call("ElectricTilesControlInterface", "recalculateSurface", { surface_index = game.players[event_data.player_index].surface_index })
        --
    end
end
