local utils = require("scripts.modules.utils")

local temps = require("scripts.modules.temps")

return function()
    --
    game.print(serpent.block(temps.get("cached-tiles")))

    utils.resetTileCache()
    --
end
