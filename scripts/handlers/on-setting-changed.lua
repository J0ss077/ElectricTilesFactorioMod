local recalculate_all_surfaces_fun = require("scripts.functions.recalculate-all-surfaces")

local settings_loader_fun = require("scripts.loaders.settings-loader")

local utilities = require("scripts.modules.utilities")

local temporals = require("scripts.modules.temporals")

return function(_data_)
    --
    utilities.debugInGame("Settings changed, reloading settings ...")

    -----------------------------------------------------------------

    local setting001 = temporals.get("chunk-area-size")

    utilities.debugInGame("Current chunk-area-size: " .. tostring(setting001))

    local setting002 = temporals.get("update-delay")

    utilities.debugInGame("Current update-delay: " .. tostring(setting002))

    ---------------------------

    settings_loader_fun(_data_)

    ---------------------------

    utilities.debugInGame("New chunk-area-size: " .. tostring(temporals.get("chunk-area-size")))

    if setting001 ~= temporals.get("chunk-area-size") then recalculate_all_surfaces_fun(_data_) end

    utilities.debugInGame("New update-delay: " .. tostring(temporals.get("update-delay")))

    if setting002 ~= temporals.get("update-delay") then --[[ Damm... now its different ]] end
    --
    --
end
