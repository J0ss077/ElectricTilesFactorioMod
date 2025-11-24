local definitions = require("scripts.var.definitions")

local vanilla = data.raw["item-subgroup"]["terrain"]

data:extend({
    {
        type = "item-subgroup",
        --
        name = definitions.item_prefix .. vanilla.name,
        --
        group = vanilla.group,
        --
        order = vanilla.order .. "-a[electric-tiles]",
    }
})
