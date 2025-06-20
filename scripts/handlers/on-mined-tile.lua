local utils = require("scripts.modules.utils")

return function(force, surface, old_tiles)
    --
    local lock = false

    for __, old_tile_data in ipairs(old_tiles) do
        --
        if old_tile_data.old_tile.name == "electric-tile" then
            --
            utils.cacheTile(old_tile_data.position, surface, force, false, true)

            if lock == false then lock = true end
            --
        end
        --
    end

    if lock then utils.restartUpdateTimer() end
    --
end
