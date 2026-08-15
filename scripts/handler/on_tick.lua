local update_daemon = require("scripts.unique.update-daemon")

script.on_event(defines.events.on_tick, function (event_data) update_daemon.countdown_timers() end)
