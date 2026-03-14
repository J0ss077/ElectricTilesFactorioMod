local definitions = require("scripts.var.definitions")

local common_utils = require("scripts.lib.common-utils")

local __proto_names = {

    stone_path = "stone-path",
    stone_brck = "stone-brick",

    concrete = "concrete",

    hazard_concrete = "hazard-concrete",
    haz_concrete_le = "hazard-concrete-left",
    haz_concrete_ri = "hazard-concrete-right",

    refined_concrete = "refined-concrete",

    refined_hazard_concrete = "refined-hazard-concrete",
    refined_haz_concrete_le = "refined-hazard-concrete-left",
    refined_haz_concrete_ri = "refined-hazard-concrete-right",
}

--- phase 01: base adaptations

--- stone path

local tile_sto_path = table.deepcopy(data.raw.tile[__proto_names.stone_path])

--tile_sto_path.layer = tile_sto_path.layer + 32

local item_sto_brck = table.deepcopy(data.raw.item[__proto_names.stone_brck])

item_sto_brck.subgroup = nil

--- concrete

local tile_concrete = table.deepcopy(data.raw.tile[__proto_names.concrete])

--tile_concrete.layer = tile_concrete.layer + 32

local item_concrete = table.deepcopy(data.raw.item[__proto_names.concrete])

item_concrete.subgroup = nil

--- hazard concrete

local item_hazard_concrete = table.deepcopy(data.raw.item[__proto_names.hazard_concrete])

item_hazard_concrete.subgroup = nil

local tile_hazard_concrete_le = table.deepcopy(data.raw.tile[__proto_names.haz_concrete_le])
local tile_hazard_concrete_ri = table.deepcopy(data.raw.tile[__proto_names.haz_concrete_ri])

tile_hazard_concrete_le.next_direction = definitions.tile_prefix .. __proto_names.haz_concrete_ri
tile_hazard_concrete_ri.next_direction = definitions.tile_prefix .. __proto_names.haz_concrete_le

--tile_hazard_concrete_le.layer = tile_hazard_concrete_le.layer + 32
--tile_hazard_concrete_ri.layer = tile_hazard_concrete_ri.layer + 32

--- extra configuration

tile_hazard_concrete_ri.placeable_by = { item = definitions.item_prefix .. __proto_names.hazard_concrete, count = 1 }

tile_hazard_concrete_ri.minable.result = tile_hazard_concrete_ri.placeable_by.item

local hazard_concrete_recipe = {
    --
    energy_required = .25,
    --
    category = "crafting",
    --
    ingredients = { { type = "item", name = definitions.item_prefix .. item_concrete.name, amount = 10 } }
}

--- refined concrete

local tile_ref_conc = table.deepcopy(data.raw.tile[__proto_names.refined_concrete])

--tile_ref_conc.layer = tile_ref_conc.layer + 32

local item_ref_conc = table.deepcopy(data.raw.item[__proto_names.refined_concrete])

item_ref_conc.subgroup = nil

--- refined hazard concrete

local item_ref_hazard_conc = table.deepcopy(data.raw.item[__proto_names.refined_hazard_concrete])

item_ref_hazard_conc.subgroup = nil

local tile_ref_hazard_conc_le = table.deepcopy(data.raw.tile[__proto_names.refined_haz_concrete_le])
local tile_ref_hazard_conc_ri = table.deepcopy(data.raw.tile[__proto_names.refined_haz_concrete_ri])

tile_ref_hazard_conc_le.next_direction = definitions.tile_prefix .. __proto_names.refined_haz_concrete_ri
tile_ref_hazard_conc_ri.next_direction = definitions.tile_prefix .. __proto_names.refined_haz_concrete_le

--tile_ref_hazard_conc_le.layer = tile_ref_hazard_conc_le.layer + 32
--tile_ref_hazard_conc_ri.layer = tile_ref_hazard_conc_ri.layer + 32

--- extra configuration

tile_ref_hazard_conc_ri.placeable_by = { item = definitions.item_prefix .. __proto_names.refined_hazard_concrete, count = 1 }

tile_ref_hazard_conc_ri.minable.result = tile_ref_hazard_conc_ri.placeable_by.item

local ref_hazard_conc_recipe = {
    --
    energy_required = .25,
    --
    category = "crafting",
    --
    ingredients = { { type = "item", name = definitions.item_prefix .. item_ref_conc.name, amount = 10 } }
}

ElectricTilesDataInterface.modTilePrototypes({
    --
    { tile = tile_sto_path,           item = item_sto_brck,        others = { use_default_recipe = true } },
    --
    { tile = tile_concrete,           item = item_concrete,        others = { use_default_recipe = true } },
    --
    { tile = tile_ref_conc,           item = item_ref_conc,        others = { use_default_recipe = true } },
    --
    { tile = tile_hazard_concrete_le, item = item_hazard_concrete, others = { result_amount = 10 },       recipe = hazard_concrete_recipe },
    --
    { tile = tile_ref_hazard_conc_le, item = item_ref_hazard_conc, others = { result_amount = 10 },       recipe = ref_hazard_conc_recipe },
    --
    { tile = tile_hazard_concrete_ri },
    --
    { tile = tile_ref_hazard_conc_ri },
})

--- phase 02: upgrade recipes

local modded_ref_conc_item = data.raw.item[definitions.item_prefix .. "refined-concrete"]
local modded_st_brick_item = data.raw.item[definitions.item_prefix .. "stone-brick"]
local modded_concrete_item = data.raw.item[definitions.item_prefix .. "concrete"]

local base_recipe_name = { "", { "recipe-name.FO77ET-upgrade-prefix" }, " " }

local L01 = common_utils.combine_arrays(base_recipe_name, table.pack(table.unpack(modded_concrete_item.localised_name --[[@as table]], 2)), true)
local L02 = common_utils.combine_arrays(base_recipe_name, table.pack(table.unpack(modded_ref_conc_item.localised_name --[[@as table]], 2)), true)

local upgrade_to_concrete_recipe = {
    --
    type = "recipe",
    --
    enabled = false,
    --
    category = "crafting-with-fluid",
    --
    name = modded_st_brick_item.name .. "-to-" .. modded_concrete_item.name,
    --
    energy_required = 10,
    --
    auto_recycle = false,
    --
    localised_name = L01,
    --
    subgroup = definitions.item_prefix .. "terrain",
    --
    icons = table.deepcopy(modded_concrete_item.icons),
    --
    order = modded_concrete_item.order .. "-u[upgrade]",
    --
    results = { { type = "item", name = modded_concrete_item.name, amount = 10 } },
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
    category = "crafting-with-fluid",
    --
    name = modded_concrete_item.name .. "-to-" .. modded_ref_conc_item.name,
    --
    energy_required = 15,
    --
    auto_recycle = false,
    --
    localised_name = L02,
    --
    subgroup = definitions.item_prefix .. "terrain",
    --
    icons = table.deepcopy(modded_ref_conc_item.icons),
    --
    order = modded_ref_conc_item.order .. "-u[upgrade]",
    --
    results = { { type = "item", name = modded_ref_conc_item.name, amount = 10 } },
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
