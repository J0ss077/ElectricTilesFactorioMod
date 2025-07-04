local process_cached_tiles_fun = require("scripts.functions.process-cached-tiles")

local update_timer = require("scripts.objects.update-timer")

return function(_data_)
    --
    if update_timer.count_down() then process_cached_tiles_fun() end
    --
end
