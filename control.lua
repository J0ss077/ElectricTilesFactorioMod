require("scripts.loaders.settings-loader")

require("scripts.loaders.distress-vars-loader")

-----------------------------------------------

local on_tick_fun = require("scripts.handlers.on-tick")

local on_mined_tile_fun = require("scripts.handlers.on-mined-tile")

local on_built_tile_fun = require("scripts.handlers.on-built-tile")

local on_built_entity_fun = require("scripts.handlers.on-built-entity")

-----------------------------------------------------------------------

script.on_event(defines.events.on_tick, function(data) on_tick_fun(data.tick) end)

----------------------------------------------------------------------------------

script.on_event(defines.events.on_built_entity,       function(data) on_built_entity_fun(data.entity) end, { { filter = "type", type = "electric-pole" } })

script.on_event(defines.events.on_robot_built_entity, function(data) on_built_entity_fun(data.entity) end, { { filter = "type", type = "electric-pole" } })

-----------------------------------------------------------------------------------------------------------------------------------------------------------

script.on_event(defines.events.on_player_built_tile, function(data) on_built_tile_fun(game.players[data.player_index].force, game.surfaces[data.surface_index], data.tiles, data.tile) end)

script.on_event(defines.events.on_robot_built_tile,  function(data) on_built_tile_fun(data.robot.force,                      game.surfaces[data.surface_index], data.tiles, data.tile) end)

script.on_event(defines.events.on_player_mined_tile, function(data) on_mined_tile_fun(game.players[data.player_index].force, game.surfaces[data.surface_index], data.tiles) end)

script.on_event(defines.events.on_robot_mined_tile,  function(data) on_mined_tile_fun(data.robot.force,                      game.surfaces[data.surface_index], data.tiles) end)
