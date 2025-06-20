local utils = require("scripts.modules.utils")

return function(force, surface, old_tiles, tile_prototype)
    --
    if tile_prototype.name ~= "electric-tile" then return end

    for __, old_tile_data in ipairs(old_tiles) do
        --
        utils.cacheTile(old_tile_data.position, surface, force, true, false)
        --
    end

    utils.restartUpdateTimer()
    --
end
