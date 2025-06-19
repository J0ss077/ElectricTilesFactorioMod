data:extend({
    {
        type = "recipe",

        enabled = false,

        subgroup = "terrain",

        energy_required = 0.5,

        name = "electric-tile",

        category = "metallurgy-or-assembling",

        ingredients = {

            { type = "item", name = "concrete",     amount = 1 },

            { type = "item", name = "iron-stick",   amount = 2 },

            { type = "item", name = "copper-cable", amount = 4 },
        },

        results = { { type = "item", name = "electric-tile", amount = 1 } }
    }
})
