data:extend({
    {
        effects = {},
        icon_size = 256,
        type = "technology",
        name = "electric-tiles-tech",
        prerequisites = { "concrete" },
        icon = "__electric-tiles__/graphics/technology/electric-tiles-tech.png",
        unit = {
            time = 60,
            count = 200,
            ingredients = {
                { "automation-science-pack", 1 },
                { "logistic-science-pack",   1 },
            }
        }
    }
})
