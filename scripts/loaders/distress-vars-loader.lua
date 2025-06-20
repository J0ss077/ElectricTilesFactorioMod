local utils = require("scripts.modules.utils")

local temps = require("scripts.modules.temps")

--// 1st : Timers for updating the cached tiles

temps.set("update-timer", { enabled = false, tick = 0 })

temps.set("forced-timer", { enabled = false, tick = 0 })

--// 2nd : Aux collision box

temps.set("aux-collision-box", { left_top = { x = -0.25, y = -0.25 }, right_bottom = { x = 0.25, y = 0.25 } })

--// 3rd : All proxies names

local _names_ = {}

for i = 0.5, temps.get("chunk-area-size") / 2, 0.5 do
    --
    table.insert(_names_, utils.getProxyNameFromSupplyDistance(i))
    --
end

temps.set("proxies-names", _names_)

--// 4th : Cache storage for tiles

temps.set("cached-tiles", {})
