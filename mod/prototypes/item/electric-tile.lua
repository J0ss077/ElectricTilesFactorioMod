data:extend({
    {
        type = "item",

        icon_size = 64,

        weight = 10000,

        stack_size = 100,

        subgroup = "terrain",

        name = "electric-tile",

        order = "b[concrete]-a[plain]-z[electric-tile]",

        icon = "__electric-tiles__/graphics/icon/electric-tile.png",

        place_as_tile = {

            condition_size = 1,

            result = "electric-tile",

            condition = { layers = { water_tile = true } }
        }
    }
})
