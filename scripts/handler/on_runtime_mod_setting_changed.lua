local data_loader = require("scripts.unique.data-loader")

local updt_daemon = require("scripts.unique.update-daemon")

script.on_event(defines.events.on_runtime_mod_setting_changed, function(event_data)
    -----------
    data_loader.load_runtime_settings()

        if event_data.setting == "F077ET-base-update-delay" then updt_daemon.reset_base_timer()

    elseif event_data.setting == "F077ET-long-update-delay" then updt_daemon.reset_long_timer()

    elseif event_data.setting == "F077ET-chunk-subdivision" then remote.call("ElectricTilesControlInterface", "recalculateAllSurfaces")
    ---
    end
    ---
end)
