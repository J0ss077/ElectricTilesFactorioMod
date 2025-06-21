local recipe_category = "advanced-crafting"

if mods["space-age"] then
    --
    recipe_category = "metallurgy-or-assembling"
    --
end

data:extend({
    {
        type = "recipe",

        enabled = false,

        subgroup = "terrain",

        energy_required = 0.5,

        name = "electric-tile",

        category = recipe_category,

        ingredients = {

            { type = "item", name = "concrete",     amount = 1 },

            { type = "item", name = "iron-stick",   amount = 2 },

            { type = "item", name = "copper-cable", amount = 4 },
        },

        results = { { type = "item", name = "electric-tile", amount = 1 } }
    }
})
