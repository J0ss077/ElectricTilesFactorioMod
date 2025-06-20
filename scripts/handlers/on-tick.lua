local utils = require("scripts.modules.utils")

local process_cached_tiles_fun = require("scripts.functions.process-cached-tiles")

----------------------------------------------------------------------------------

return function(tick)
    --
    if utils.countDownUpdateTimer() then process_cached_tiles_fun() end
    --
end
