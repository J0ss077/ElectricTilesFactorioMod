local temps = require("scripts.modules.temps")

-----------------------------------------------------------------------------

local setting001 = settings.startup["electric-tiles-chunk-subdivision"].value

if setting001 == "8x8" then
    --
    temps.set("chunk-area-size", 08.0)
    --
elseif setting001 == "16x16" then
    --
    temps.set("chunk-area-size", 16.0)
    --
elseif setting001 == "32x32" then
    --
    temps.set("chunk-area-size", 32.0)
    --
end

------------------------------------------------------------------------

local setting002 = settings.startup["electric-tiles-update-delay"].value

if setting002 == "1 second" then
    --
    temps.set("update-delay", 1.00)
    --
elseif setting002 == "0.75 seconds" then
    --
    temps.set("update-delay", 0.75)
    --
elseif setting002 == "0.50 seconds" then
    --
    temps.set("update-delay", 0.50)
    --
end

----------------------------------------------------------------------------

temps.set("debug-mode", settings.startup["electric-tiles-debug-mode"].value)
