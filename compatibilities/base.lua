local definitions = require("scripts.var.definitions")
local common_utils = require("scripts.lib.common-utils")

--- phase 01: base adaptations

--- stone path

local tile_stone_path = table.deepcopy(data.raw.tile["stone-path"])

tile_stone_path.layer = tile_stone_path.layer + 64

local item_stone_brick = table.deepcopy(data.raw.item["stone-brick"])

item_stone_brick.subgroup = nil

--- concrete

local tile_concrete = table.deepcopy(data.raw.tile["concrete"])

tile_concrete.layer = tile_concrete.layer + 64

local item_concrete = table.deepcopy(data.raw.item["concrete"])

item_concrete.subgroup = nil

--- hazard concrete

local item_hazard_concrete = table.deepcopy(data.raw.item["hazard-concrete"])

item_hazard_concrete.subgroup = nil

local tile_hazard_concrete_left = table.deepcopy(data.raw.tile["hazard-concrete-left"])

tile_hazard_concrete_left.next_direction = definitions.tile_prefix .. "hazard-concrete-right"
tile_hazard_concrete_left.layer = tile_hazard_concrete_left.layer + 64

local tile_hazard_concrete_right = table.deepcopy(data.raw.tile["hazard-concrete-right"])

tile_hazard_concrete_right.next_direction = definitions.tile_prefix .. "hazard-concrete-left"
tile_hazard_concrete_right.layer = tile_hazard_concrete_right.layer + 64

--- extra configuration

local new_hazard_concrete_name = definitions.item_prefix .. "hazard-concrete"

tile_hazard_concrete_right.placeable_by = { item = new_hazard_concrete_name, count = 1 }
tile_hazard_concrete_right.minable.result = new_hazard_concrete_name

local hazard_concrete_recipe = {
    --
    energy_required = .25,
    --
    category = "crafting",
    --
    ingredients = { { type = "item", name = definitions.item_prefix .. item_concrete.name, amount = 10 } }
}

--- refined concrete

local tile_refined_concrete = table.deepcopy(data.raw.tile["refined-concrete"])

tile_refined_concrete.layer = tile_refined_concrete.layer + 64

local item_refined_concrete = table.deepcopy(data.raw.item["refined-concrete"])

item_refined_concrete.subgroup = nil

--- refined hazard concrete

local item_refined_hazard_concrete = table.deepcopy(data.raw.item["refined-hazard-concrete"])

item_refined_hazard_concrete.subgroup = nil

local tile_refined_hazard_concrete_left = table.deepcopy(data.raw.tile["refined-hazard-concrete-left"])

tile_refined_hazard_concrete_left.next_direction = definitions.tile_prefix .. "refined-hazard-concrete-right"
tile_refined_hazard_concrete_left.layer = tile_refined_hazard_concrete_left.layer + 64

local tile_refined_hazard_concrete_right = table.deepcopy(data.raw.tile["refined-hazard-concrete-right"])

tile_refined_hazard_concrete_right.next_direction = definitions.tile_prefix .. "refined-hazard-concrete-left"
tile_refined_hazard_concrete_right.layer = tile_refined_hazard_concrete_right.layer + 64

--- extra configuration

local new_refined_hazard_concrete_name = definitions.item_prefix .. "refined-hazard-concrete"

tile_refined_hazard_concrete_right.placeable_by = { item = new_refined_hazard_concrete_name, count = 1 }
tile_refined_hazard_concrete_right.minable.result = new_refined_hazard_concrete_name

local refined_hazard_concrete_recipe = {
    --
    energy_required = .25,
    --
    category = "crafting",
    --
    ingredients = { { type = "item", name = definitions.item_prefix .. item_refined_concrete.name, amount = 10 } }
}

ElectricTilesDataInterface.modTilePrototypes({
    --
    { tile = tile_stone_path,                   item = item_stone_brick,             others = { use_default_recipe = true } },
    --
    { tile = tile_concrete,                     item = item_concrete,                others = { use_default_recipe = true } },
    --
    { tile = tile_hazard_concrete_left,         item = item_hazard_concrete,         others = { result_amount = 10 },       recipe = hazard_concrete_recipe },
    --
    { tile = tile_hazard_concrete_right },
    --
    { tile = tile_refined_concrete,             item = item_refined_concrete,        others = { use_default_recipe = true } },
    --
    { tile = tile_refined_hazard_concrete_left, item = item_refined_hazard_concrete, others = { result_amount = 10 },       recipe = refined_hazard_concrete_recipe },
    --
    { tile = tile_refined_hazard_concrete_right },
})

--- phase 02: upgrade recipes

local modded_ref_conc_item = data.raw.item[definitions.item_prefix .. "refined-concrete"]
local modded_st_brick_item = data.raw.item[definitions.item_prefix .. "stone-brick"]
local modded_concrete_item = data.raw.item[definitions.item_prefix .. "concrete"]

local base_recipe_name = { "", { "recipe-name.FO77ET-upgrade-prefix" }, " " }

local name01 = table.deepcopy(base_recipe_name)
local name02 = table.deepcopy(base_recipe_name)

common_utils.combine_arrays(name01, table.pack(table.unpack(modded_concrete_item.localised_name --[[@as table]], 2)))
common_utils.combine_arrays(name02, table.pack(table.unpack(modded_ref_conc_item.localised_name --[[@as table]], 2)))

local upgrade_to_concrete_recipe = {
    --
    type = "recipe",
    --
    enabled = false,
    --
    energy_required = 10,
    --
    auto_recycle = false,
    --
    localised_name = name01,
    --
    category = "crafting-with-fluid",
    --
    icons = table.deepcopy(modded_concrete_item.icons),
    --
    order = modded_concrete_item.order .. "-u[upgrade]",
    --
    name = modded_st_brick_item.name .. "-to-" .. modded_concrete_item.name,
    --
    results = { { type = "item", name = modded_concrete_item.name, amount = 10 } },
    --
    subgroup = definitions.item_prefix .. data.raw["item-subgroup"]["terrain"].name,
    --
    ingredients = {
        --
        { type = "item",  name = "iron-ore",                amount = 001 },
        --
        { type = "item",  name = modded_st_brick_item.name, amount = 005 },
        --
        { type = "fluid", name = "water",                   amount = 100 },
    }
}

local upgrade_to_ref_conc_recipe = {
    --
    type = "recipe",
    --
    enabled = false,
    --
    energy_required = 15,
    --
    auto_recycle = false,
    --
    localised_name = name02,
    --
    category = "crafting-with-fluid",
    --
    icons = table.deepcopy(modded_ref_conc_item.icons),
    --
    order = modded_ref_conc_item.order .. "-u[upgrade]",
    --
    name = modded_concrete_item.name .. "-to-" .. modded_ref_conc_item.name,
    --
    results = { { type = "item", name = modded_ref_conc_item.name, amount = 10 } },
    --
    subgroup = definitions.item_prefix .. data.raw["item-subgroup"]["terrain"].name,
    --
    ingredients = {
        --
        { type = "item",  name = "steel-plate",             amount = 001 },
        --
        { type = "item",  name = "iron-stick",              amount = 008 },
        --
        { type = "item",  name = modded_concrete_item.name, amount = 020 },
        --
        { type = "fluid", name = "water",                   amount = 100 },
    }
}

local arrow_icon = { scale = 0.35, icon_size = 64, icon = "__electric-tiles__/graphics/icon/upgrade-arrow.png" }

table.insert(upgrade_to_concrete_recipe.icons, arrow_icon)
table.insert(upgrade_to_ref_conc_recipe.icons, arrow_icon)

data:extend({ upgrade_to_concrete_recipe, upgrade_to_ref_conc_recipe })

table.insert(data.raw.technology["F077ET-technology"].effects, 2, { type = "unlock-recipe", recipe = upgrade_to_concrete_recipe.name })
table.insert(data.raw.technology["F077ET-technology"].effects, 5, { type = "unlock-recipe", recipe = upgrade_to_ref_conc_recipe.name })
