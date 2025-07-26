--- (PROTOTYPING) CREATE BASE ADAPTATIONS

local custom_definitions = require("definitions")

--- STONE PATH/BRICK

local tile_duplicate_stone_path = table.deepcopy(data.raw.tile["stone-path"])

tile_duplicate_stone_path.layer = tile_duplicate_stone_path.layer + 64

local item_duplicate_stone_brick = table.deepcopy(data.raw.item["stone-brick"])

item_duplicate_stone_brick.subgroup = nil

--- CONCRETE

local tile_duplicate_concrete = table.deepcopy(data.raw.tile["concrete"])

tile_duplicate_concrete.layer = tile_duplicate_concrete.layer + 64

local item_duplicate_concrete = table.deepcopy(data.raw.item["concrete"])

item_duplicate_concrete.subgroup = nil

--- HAZARD CONCRETE

local item_duplicate_hazard_concrete = table.deepcopy(data.raw.item["hazard-concrete"])

item_duplicate_hazard_concrete.subgroup = nil

local hazard_concrete_item_name = custom_definitions.item_prefix .. "hazard-concrete"

--------------------
local tile_duplicate_hazard_concrete_left = table.deepcopy(data.raw.tile["hazard-concrete-left"])

tile_duplicate_hazard_concrete_left.next_direction = custom_definitions.tile_prefix .. "hazard-concrete-right"

tile_duplicate_hazard_concrete_left.layer = tile_duplicate_hazard_concrete_left.layer + 64
--------------------
local tile_duplicate_hazard_concrete_right = table.deepcopy(data.raw.tile["hazard-concrete-right"])

tile_duplicate_hazard_concrete_right.next_direction = custom_definitions.tile_prefix .. "hazard-concrete-left"

tile_duplicate_hazard_concrete_right.placeable_by = { count = 1, item = hazard_concrete_item_name }

tile_duplicate_hazard_concrete_right.layer = tile_duplicate_hazard_concrete_right.layer + 64

tile_duplicate_hazard_concrete_right.minable.result = hazard_concrete_item_name
--------------------

local hazard_concrete_recipe = {
    --
    energy_required = 0.25,
    --
    category = "crafting",
    --
    ingredients = {
        --
        { type = "item", name = custom_definitions.item_prefix .. item_duplicate_concrete.name, amount = 10 }
        --
    },
    --
}

--- REFINED CONCRETE

local tile_duplicate_refined_concrete = table.deepcopy(data.raw.tile["refined-concrete"])

tile_duplicate_refined_concrete.layer = tile_duplicate_refined_concrete.layer + 64

local item_duplicate_refined_concrete = table.deepcopy(data.raw.item["refined-concrete"])

item_duplicate_refined_concrete.subgroup = nil

--- REFINED HAZARD CONCRETE

local item_duplicate_refined_hazard_concrete = table.deepcopy(data.raw.item["refined-hazard-concrete"])

item_duplicate_refined_hazard_concrete.subgroup = nil

local refined_hazard_concrete_item_name = custom_definitions.item_prefix .. "refined-hazard-concrete"

--------------------
local tile_duplicate_refined_hazard_concrete_left = table.deepcopy(data.raw.tile["refined-hazard-concrete-left"])

tile_duplicate_refined_hazard_concrete_left.next_direction = custom_definitions.tile_prefix .. "refined-hazard-concrete-right"

tile_duplicate_refined_hazard_concrete_left.layer = tile_duplicate_refined_hazard_concrete_left.layer + 64
--------------------
local tile_duplicate_refined_hazard_concrete_right = table.deepcopy(data.raw.tile["refined-hazard-concrete-right"])

tile_duplicate_refined_hazard_concrete_right.next_direction = custom_definitions.tile_prefix .. "refined-hazard-concrete-left"

tile_duplicate_refined_hazard_concrete_right.placeable_by = { count = 1, item = refined_hazard_concrete_item_name }

tile_duplicate_refined_hazard_concrete_right.layer = tile_duplicate_refined_hazard_concrete_right.layer + 64

tile_duplicate_refined_hazard_concrete_right.minable.result = refined_hazard_concrete_item_name
--------------------

local refined_hazard_concrete_recipe = {
    --
    energy_required = 0.25,
    --
    category = "crafting",
    --
    ingredients = {
        --
        { type = "item", name = custom_definitions.item_prefix .. item_duplicate_refined_concrete.name, amount = 10 }
        --
    },
    --
}

--- SAVE

ElectricTilesDataInterface.adaptTilePrototype({
    --
    { tile = tile_duplicate_stone_path,                   item = item_duplicate_stone_brick,             others = { use_default_recipe = true } },
    --
    { tile = tile_duplicate_concrete,                     item = item_duplicate_concrete,                others = { use_default_recipe = true } },
    --
    { tile = tile_duplicate_hazard_concrete_left,         item = item_duplicate_hazard_concrete,         others = { result_amount = 10 },       recipe = hazard_concrete_recipe },
    --
    { tile = tile_duplicate_hazard_concrete_right },
    --
    { tile = tile_duplicate_refined_concrete,             item = item_duplicate_refined_concrete,        others = { use_default_recipe = true } },
    --
    { tile = tile_duplicate_refined_hazard_concrete_left, item = item_duplicate_refined_hazard_concrete, others = { result_amount = 10 },       recipe = refined_hazard_concrete_recipe },
    --
    { tile = tile_duplicate_refined_hazard_concrete_right },
    --
})
