local temporals = require("scripts.modules.temporals")

temporals.set("debug-mode", settings.startup["electric-tiles-debug-mode"].value)

--------------------------------------------------------------------------------

return function(_data_)
    --
    local setting001 = settings.global["electric-tiles-chunk-subdivision"].value
    --
    local setting002 = settings.global["electric-tiles-update-delay"].value
    --
    if setting001 == "8x8" then
        --
        temporals.set("chunk-area-size", 08.0)
        --
    elseif setting001 == "16x16" then
        --
        temporals.set("chunk-area-size", 16.0)
        --
    elseif setting001 == "32x32" then
        --
        temporals.set("chunk-area-size", 32.0)
        --
    end
    --
    if setting002 == "1 second" then
        --
        temporals.set("update-delay", 60)
        --
    elseif setting002 == "0.75 seconds" then
        --
        temporals.set("update-delay", 45)
        --
    elseif setting002 == "0.50 seconds" then
        --
        temporals.set("update-delay", 30)
        --
    end
    --
end
