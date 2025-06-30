local utilities = require("scripts.modules.utilities")

local temporals = require("scripts.modules.temporals")

if not temporals.get("debug-mode") then return end

--------------------------------------------------

local base_item = {

    type = "item",
    --
    icon_size = 64,
    --
    stack_size = 1,
    --
    weight = 1000000,
    --
    auto_recycle = false,
    --
    flags = { "not-stackable", "only-in-cursor" },
    --
    icon = "__electric-tiles__/graphics/icons/electric-proxy.png"
}

local prototypes = {}

for i = 0.5, 16.0, 0.5 do
    --
    local prototype = table.deepcopy(base_item) -- make new

    local name = utilities.getProxyNameFromSupplyDistance(i)

    prototype.name = name

    prototype.place_result = name

    table.insert(prototypes, prototype)
    --
end

data:extend(prototypes)
