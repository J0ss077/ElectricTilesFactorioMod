require("__core__.lualib.util")

require("scripts.unique.data-loader").load_startup_settings()

require("scripts.unique.data-loader").load_runtime_settings()

require("scripts.unique.data-loader").load_temp_data()

require("scripts.handler.on_init")

require("scripts.handler.on_load")

require("scripts.handler.on_tick")

require("scripts.handler.on_configuration_changed")

require("scripts.handler.on_runtime_mod_setting_changed")

require("scripts.handler.on_built_pole")

require("scripts.handler.on_entity_built_tile")

require("scripts.handler.on_entity_mined_tile")

require("scripts.handler.script_raised_destroy")

require("scripts.handler.script_raised_set_tiles")

require("control-interface")

require("console")
