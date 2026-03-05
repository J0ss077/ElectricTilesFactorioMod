require("__core__.lualib.util")

require("scripts.unique.data-loader").load_startup_settings()

require("scripts.unique.data-loader").load_runtime_settings()

require("scripts.unique.data-loader").load_temp_data()

local update_daemon = require("scripts.unique.update-daemon")

update_daemon.reset_base_timer()

update_daemon.reset_long_timer()

require("scripts.handler.on_init")

require("scripts.handler.on_load")

require("scripts.handler.on_configuration_changed")

require("scripts.handler.on_runtime_mod_setting_changed")

require("scripts.handler.on_built_pole")

require("scripts.handler.on_entity_built_tile")

require("scripts.handler.on_entity_mined_tile")

require("scripts.handler.script_raised_set_tiles")

require("control-interface")

require("console")
