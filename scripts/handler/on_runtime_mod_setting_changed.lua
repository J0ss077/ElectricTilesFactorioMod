local tmp_storage = require("scripts.var.temp-storage")

local data_loader = require("scripts.unique.data-loader")

local update_daemon = require("scripts.unique.update-daemon")

script.on_event(defines.events.on_runtime_mod_setting_changed, function()
    --
    local old_setting_001 = tmp_storage.get("base-update-delay")
    --
    local old_setting_002 = tmp_storage.get("long-update-delay")

    data_loader.load_runtime_settings()

    if old_setting_001 ~= tmp_storage.get("base-update-delay") then update_daemon.reset_base_timer() end
    --
    if old_setting_002 ~= tmp_storage.get("long-update-delay") then update_daemon.reset_long_timer() end
    --
end)
