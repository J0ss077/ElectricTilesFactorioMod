local utils = require("scripts.modules.utils")

local temps = require("scripts.modules.temps")

if temps.get("debug-mode") == false then return end

---------------------------------------------------

local base_item = {

    type = "item",

    stack_size = 1,

    weight = 1000000,

    auto_recycle = false,

    flags = { "not-stackable", "only-in-cursor" },

    icon = "__electric-tiles__/graphics/icon/electric-proxy.png",

    icon_size = 64,
}

local item_prototypes = {}

for i = 0.5, temps.get("chunk-area-size") / 2, 0.5 do
    --
    local item = table.deepcopy(base_item) --- new item

    local name = utils.getProxyNameFromSupplyDistance(i)

    item.place_result = name

    item.name = name

    table.insert(item_prototypes, item)
    --
end

data:extend(item_prototypes)
