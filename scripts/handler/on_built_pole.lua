local network_controller = require("scripts.controller.network-controller")

local events = { defines.events.on_built_entity, defines.events.on_robot_built_entity, defines.events.script_raised_built }

local filter = { { filter = "type", type = "electric-pole" } }

for i0, event in ipairs(events) do
    --
    script.on_event(event, function(event_data) network_controller.update_electric_pole(event_data.entity) end, filter)
    --
end
