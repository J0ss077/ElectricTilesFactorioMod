data:extend({
    {
        type = "technology",

        name = "electric-tiles-tech",

        prerequisites = { "concrete" },

        icon = "__electric-tiles__/graphics/technology/electric-tiles-tech.png",

        icon_size = 256,

        unit = { count = 200, ingredients = { { "logistic-science-pack", 1 } }, time = 60 },

        effects = { { type = "unlock-recipe", recipe = "electric-tile" } }
    }
})
