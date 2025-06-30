require("prototypes.technology.electric-tiles-tech")

require("scripts.loaders.settings-loader") --- debug

require("prototypes.entity.electric-proxy")

require("prototypes.item.electric-proxy")

--require("prototypes.data.data-carrier")

require("data-interface")

-------------------------------------------------------------------------------------------------------------------------------

local adaptations = { { "stone-brick", "stone-path" }, { "concrete", "concrete" }, { "refined-concrete", "refined-concrete" } }

local prototypes = {}

for __, data_pair in ipairs(adaptations) do
    --
    table.insert(prototypes, {
        --
        item = data.raw.item[data_pair[1]],
        --
        tile = data.raw.tile[data_pair[2]],
        --
        others = { use_default_recipe = true }
        --
    })
    --
end

ElectricTilesDataInterface.adaptTilePrototype(prototypes)

---------------------------------------------------------

local utilities = require("scripts.modules.utilities")

local custom_definitions = require("definitions")

local adapted_re_concr = data.raw.item[custom_definitions.item_prefix .. "refined-concrete"]

local adapted_stone_br = data.raw.item[custom_definitions.item_prefix .. "stone-brick"]

local adapted_concrete = data.raw.item[custom_definitions.item_prefix .. "concrete"]

local recipe_001 = {
    --
    icons = {},
    --
    type = "recipe",
    --
    enabled = false,
    --
    energy_required = 10,
    --
    subgroup = "terrain",
    --
    category = "crafting-with-fluid",
    --
    order = adapted_stone_br.order .. "-z[upgrade]",
    --
    name = adapted_stone_br.name .. "-to-" .. adapted_concrete.name,
    --
    results = { { type = "item", name = adapted_concrete.name, amount = 10 } },
    --
    ingredients = {
        --
        { type = "item",  name = "iron-ore",            amount = 001 },
        --
        { type = "item",  name = adapted_stone_br.name, amount = 005 },
        --
        { type = "fluid", name = "water",               amount = 100 },
        --
    },
    --
    localised_name = { "", "(", { "item-name.__upper_case_upgrade__" }, " ", { "item-name.__upper_case_electric__" }, ") ", { "item-name.stone-brick" } }
    --
}

local recipe_002 = {
    --
    icons = {},
    --
    type = "recipe",
    --
    enabled = false,
    --
    energy_required = 15,
    --
    subgroup = "terrain",
    --
    category = "crafting-with-fluid",
    --
    order = adapted_concrete.order .. "-z[upgrade]",
    --
    name = adapted_concrete.name .. "-to-" .. adapted_re_concr.name,
    --
    results = { { type = "item", name = adapted_re_concr.name, amount = 10 } },
    --
    ingredients = {
        --
        { type = "item",  name = "steel-plate",         amount = 001 },
        --
        { type = "item",  name = "iron-stick",          amount = 008 },
        --
        { type = "item",  name = adapted_concrete.name, amount = 020 },
        --
        { type = "fluid", name = "water",               amount = 100 },
        --
    },
    --
    localised_name = { "", "(", { "item-name.__upper_case_upgrade__" }, " ", { "item-name.__upper_case_electric__" }, ") ", { "item-name.concrete" } }
    --
}

--- TEMP ICON

local arrow = { scale = 0.35, icon_size = 64, icon = "__electric-tiles__/graphics/icons/upgrade-arrow.png" }

--- RECIPES ICONS

recipe_001.icons = table.deepcopy(adapted_stone_br.icons)

recipe_002.icons = table.deepcopy(adapted_concrete.icons)

table.insert(recipe_001.icons, arrow)

table.insert(recipe_002.icons, arrow)

--- SAVE RECIPES

data:extend({ recipe_001, recipe_002 })

table.insert(data.raw.technology["electric-tiles-tech"].effects, { type = "unlock-recipe", recipe = recipe_001.name })

table.insert(data.raw.technology["electric-tiles-tech"].effects, { type = "unlock-recipe", recipe = recipe_002.name })
