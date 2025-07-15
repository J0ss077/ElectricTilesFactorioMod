require("scripts.loaders.settings-loader")()

require("scripts.loaders.temporals-loader")()

require("control-interface")

require("console") -- commnds

local on_built_tile = require("scripts.handlers.on-built-tile")

local on_mined_tile = require("scripts.handlers.on-mined-tile")

local on_built_entity = require("scripts.handlers.on-built-entity")

-------------------------------------------------------------------

script.on_event(defines.events.on_tick, require("scripts.handlers.on-tick"))

script.on_event(defines.events.on_runtime_mod_setting_changed, require("scripts.handlers.on-setting-changed"))

script.on_event(defines.events.script_raised_set_tiles, require("scripts.handlers.on-script-raised-set-tiles"))

---------------------------------------------------------------------------------------------------------------

script.on_event(defines.events.on_built_entity, function(_data_) on_built_entity(_data_.entity) end, { { filter = "type", type = "electric-pole" } })

script.on_event(defines.events.on_robot_built_entity, function(_data_) on_built_entity(_data_.entity) end, { { filter = "type", type = "electric-pole" } })

-----------------------------------------------------------------------------------------------------------------------------------------------------------

script.on_event({ defines.events.on_player_built_tile, defines.events.on_robot_built_tile }, function(_data_)
    --
    on_built_tile(game.surfaces[_data_.surface_index].name, _data_.tiles, _data_.tile)
    --
end)

script.on_event({ defines.events.on_player_mined_tile, defines.events.on_robot_mined_tile }, function(_data_)
    --
    on_mined_tile(game.surfaces[_data_.surface_index].name, _data_.tiles) --- handlers
    --
end)
