local surface_utils = require("scripts.lib.surface-utils")

local common_utils = require("scripts.lib.common-utils")

return function(event_data)
    --
    if not event_data.surface_index then return end
    --
    local surface = game.surfaces[event_data.surface_index]

    -------------------------------------------------------
    -------------------------------------------------------

    common_utils.debug_inGame("recalculating surface '" .. surface.name .. "' ...", true)

    surface_utils.recalculate_surface(surface)
    --
    --
end
