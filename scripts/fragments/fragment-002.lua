--- (PROTOTYPING) CREATE BASE ADAPTATIONS

local custom_definitions = require("definitions")

--- STONE PATH/BRICK

local tile_reference_stone_path = data.raw.tile["stone-path"]

local item_reference_stone_brick = data.raw.item["stone-brick"]

--- CONCRETE

local tile_reference_concrete = data.raw.tile["concrete"]

local item_reference_concrete = data.raw.item["concrete"]

--- HAZARD CONCRETE

local item_reference_hazard_concrete = data.raw.item["hazard-concrete"]

local hazard_concrete_item_name = custom_definitions.item_prefix .. "hazard-concrete"

local tile_duplicate_hazard_concrete_left = table.deepcopy(data.raw.tile["hazard-concrete-left"])

local tile_duplicate_hazard_concrete_right = table.deepcopy(data.raw.tile["hazard-concrete-right"])

tile_duplicate_hazard_concrete_left.next_direction = custom_definitions.tile_prefix .. "hazard-concrete-right"

tile_duplicate_hazard_concrete_right.next_direction = custom_definitions.tile_prefix .. "hazard-concrete-left"

tile_duplicate_hazard_concrete_right.placeable_by = { count = 1, item = hazard_concrete_item_name }

tile_duplicate_hazard_concrete_right.minable.result = hazard_concrete_item_name

local hazard_concrete_recipe = {
    --
    energy_required = 0.25,
    --
    category = "crafting",
    --
    ingredients = {
        --
        { type = "item", name = custom_definitions.item_prefix .. item_reference_concrete.name, amount = 10 }
        --
    },
    --
}

--- REFINED CONCRETE

local tile_reference_refined_concrete = data.raw.tile["refined-concrete"]

local item_reference_refined_concrete = data.raw.item["refined-concrete"]

--- REFINED HAZARD CONCRETE

local item_reference_refined_hazard_concrete = data.raw.item["refined-hazard-concrete"]

local refined_hazard_concrete_item_name = custom_definitions.item_prefix .. "refined-hazard-concrete"

local tile_duplicate_refined_hazard_concrete_left = table.deepcopy(data.raw.tile["refined-hazard-concrete-left"])

local tile_duplicate_refined_hazard_concrete_right = table.deepcopy(data.raw.tile["refined-hazard-concrete-right"])

tile_duplicate_refined_hazard_concrete_left.next_direction = custom_definitions.tile_prefix .. "refined-hazard-concrete-right"

tile_duplicate_refined_hazard_concrete_right.next_direction = custom_definitions.tile_prefix .. "refined-hazard-concrete-left"

tile_duplicate_refined_hazard_concrete_right.placeable_by = { count = 1, item = refined_hazard_concrete_item_name }

tile_duplicate_refined_hazard_concrete_right.minable.result = refined_hazard_concrete_item_name

local refined_hazard_concrete_recipe = {
    --
    energy_required = 0.25,
    --
    category = "crafting",
    --
    ingredients = {
        --
        { type = "item", name = custom_definitions.item_prefix .. item_reference_refined_concrete.name, amount = 10 }
        --
    },
    --
}

--- SAVE

ElectricTilesDataInterface.adaptTilePrototype({
    --
    { tile = tile_reference_stone_path,                   item = item_reference_stone_brick,             others = { use_default_recipe = true } },
    --
    { tile = tile_reference_concrete,                     item = item_reference_concrete,                others = { use_default_recipe = true } },
    --
    { tile = tile_duplicate_hazard_concrete_left,         item = item_reference_hazard_concrete,         others = { result_amount = 10 },       recipe = hazard_concrete_recipe },
    --
    { tile = tile_duplicate_hazard_concrete_right },
    --
    { tile = tile_reference_refined_concrete,             item = item_reference_refined_concrete,        others = { use_default_recipe = true } },
    --
    { tile = tile_duplicate_refined_hazard_concrete_left, item = item_reference_refined_hazard_concrete, others = { result_amount = 10 },       recipe = refined_hazard_concrete_recipe },
    --
    { tile = tile_duplicate_refined_hazard_concrete_right },
    --
})
