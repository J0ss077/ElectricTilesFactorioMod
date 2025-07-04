--- (PROTOTYPING) CREATE UPGRADE RECIPES

local custom_definitions = require("definitions")

local utilities = require("scripts.modules.utilities")

local adapted_ref_conc = data.raw.item[custom_definitions.item_prefix .. "refined-concrete"]

local adapted_st_brick = data.raw.item[custom_definitions.item_prefix .. "stone-brick"]

local adapted_concrete = data.raw.item[custom_definitions.item_prefix .. "concrete"]

--- UPGRADE BRICKS TO CONCRETE RECIPE

local upgrade_to_concrete_recipe = {
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
    auto_recycle = false,
    --
    category = "crafting-with-fluid",
    --
    order = adapted_concrete.order .. "-z[upgrade]",
    --
    name = adapted_st_brick.name .. "-to-" .. adapted_concrete.name,
    --
    results = { { type = "item", name = adapted_concrete.name, amount = 10 } },
    --
    ingredients = {
        --
        { type = "item",  name = "iron-ore",            amount = 001 },
        --
        { type = "item",  name = adapted_st_brick.name, amount = 005 },
        --
        { type = "fluid", name = "water",               amount = 100 },
        --
    },
    --
}

--- UPGRADE CONCRETE TO REFINED CONCRETE

local upgrade_to_ref_conc_recipe = {
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
    auto_recycle = false,
    --
    category = "crafting-with-fluid",
    --
    order = adapted_ref_conc.order .. "-z[upgrade]",
    --
    name = adapted_concrete.name .. "-to-" .. adapted_ref_conc.name,
    --
    results = { { type = "item", name = adapted_ref_conc.name, amount = 10 } },
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
}

--- MODIFICATIONS

local base_name = { "", "(", { "item-name.__upper_case_upgrade__" }, " ", { "item-name.__lower_case_to__" }, ") " }

local name_001 = table.deepcopy(base_name)

local name_002 = table.deepcopy(base_name)

utilities.concatArrayTables(name_001, table.pack(table.unpack(adapted_concrete.localised_name, 2)))

utilities.concatArrayTables(name_002, table.pack(table.unpack(adapted_ref_conc.localised_name, 2)))

upgrade_to_concrete_recipe.localised_name = name_001

upgrade_to_ref_conc_recipe.localised_name = name_002

local arrow = { scale = 0.35, icon_size = 64, icon = "__electric-tiles__/graphics/icons/upgrade-arrow.png" }

upgrade_to_concrete_recipe.icons = table.deepcopy(adapted_concrete.icons)

upgrade_to_ref_conc_recipe.icons = table.deepcopy(adapted_ref_conc.icons)

table.insert(upgrade_to_concrete_recipe.icons, arrow)

table.insert(upgrade_to_ref_conc_recipe.icons, arrow)

--- SAVE

data:extend({ upgrade_to_concrete_recipe, upgrade_to_ref_conc_recipe })

table.insert(data.raw.technology["electric-tiles-tech"].effects, 2, { type = "unlock-recipe", recipe = upgrade_to_concrete_recipe.name })

table.insert(data.raw.technology["electric-tiles-tech"].effects, 5, { type = "unlock-recipe", recipe = upgrade_to_ref_conc_recipe.name })
