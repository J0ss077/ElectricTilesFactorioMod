local temp_storage = require("scripts.var.temp-storage")

local data_loader = require("scripts.unique.data-loader")

script.on_event(defines.events.on_runtime_mod_setting_changed, function()
    --
    local old_setting_001 = temp_storage.get("chunk-area-size")

    local old_setting_002 = temp_storage.get("base-update-delay")

    local old_setting_003 = temp_storage.get("long-update-delay")

    data_loader.load_runtime_settings()

    if old_setting_001 ~= temp_storage.get("chunk-area-size") then
        --
        --
    end

    if old_setting_002 ~= temp_storage.get("base-update-delay") then
        --
        --
    end

    if old_setting_003 ~= temp_storage.get("long-update-delay") then
        --
        --
    end
    --
    --
end)
