local utils = require("scripts.modules.utils")

local temps = require("scripts.modules.temps")

local base_proxy = {}

local debug_proxy = {}

if temps.get("debug-mode") then
    --
    for key, value in pairs(debug_proxy) do
        --
        base_proxy[key] = value
        --
    end
    --
end

local prototypes = {}

for i = 0.5, temps.get("chunk-area-size"), 0.5 do
    --
    local prototype = table.deepcopy(base_proxy) -- new

    prototype.name = utils.getProxyNameFromSupplyDistance(i)

    prototype.supply_area_distance = i -- dinamically generate

    table.insert(prototypes, prototype)
    --
end

data:extend(prototypes)
