local surface_utils = require("scripts.lib.surface-utils")

local common_utils = require("scripts.lib.common-utils")

return function(_data_)
    --
    common_utils.debug_inGame("recalculating all surfaces ...", true)

    for i0, surface in pairs(game.surfaces) do
        --
        surface_utils.recalculate_surface(surface)
        --
    end
end
