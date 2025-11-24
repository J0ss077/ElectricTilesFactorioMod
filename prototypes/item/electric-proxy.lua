local common_utils = require("scripts.lib.common-utils")
local temp_storage = require("scripts.var.temp-storage")

if not temp_storage.get("debug-mode") then return end

local base = {
    --
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
    icon = "__electric-tiles__/graphics/icon/electric-proxy.png"
}

local prototypes = {}

for range = 0.5, 16.0, 0.5 do
    --
    local prototype = table.deepcopy(base)
    local name = common_utils.proxyName_from_supplyDistance(range)

    prototype.name = name
    prototype.place_result = name

    table.insert(prototypes, prototype)
end

data:extend(prototypes)
