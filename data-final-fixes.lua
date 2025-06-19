require("scripts.functions.settings-loader")

local utils = require("scripts.modules.utils")

local temps = require("scripts.modules.temps")

----------------------------------------------

--// FIX 001: All proxies MUST be virtually INVINCIBLE

local resistances = {}

for __, damage in pairs(data.raw["damage-type"]) do
    --
    table.insert(resistances, { type = damage.name, percent = 100 })
    --
end

for i = 0.5, temps.get("chunk-area-size") / 2, 0.5 do
    --
    data.raw["electric-pole"][utils.getProxyNameFromSupplyDistance(i)].resistances = resistances
    --
end
