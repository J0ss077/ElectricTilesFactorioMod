--- (PROTOTYPING) PATCH FOR SPACE AGE

if not mods["space-age"] then return end

local custom_definitions = require("definitions")

local names = {
    --
    { "stone-brick",             "stone-path" },
    --
    { "concrete",                "concrete" },
    --
    { "hazard-concrete",         "hazard-concrete-left" },
    --
    { "hazard-concrete",         "hazard-concrete-right" },
    --
    { "refined-concrete",        "refined-concrete" },
    --
    { "refined-hazard-concrete", "refined-hazard-concrete-left" },
    --
    { "refined-hazard-concrete", "refined-hazard-concrete-right" },
    --
}

for __, pairs in ipairs(names) do
    --
    local electric_tile_item_name = custom_definitions.item_prefix .. pairs[1]

    local electric_tile_reference = data.raw.tile[custom_definitions.tile_prefix .. pairs[2]]

    local frozen_tile_duplicate = table.deepcopy(data.raw.tile["frozen-" .. pairs[2]])

    ----------------------------------------------------------------------------------

    electric_tile_reference.frozen_variant = custom_definitions.tile_prefix .. frozen_tile_duplicate.name

    frozen_tile_duplicate.placeable_by = { count = 1, item = electric_tile_item_name }

    frozen_tile_duplicate.layer = frozen_tile_duplicate.layer + 64

    frozen_tile_duplicate.minable.result = electric_tile_item_name

    frozen_tile_duplicate.thawed_variant = electric_tile_reference.name

    ------------------------------------------------------------------------

    ElectricTilesDataInterface.adaptTilePrototype({ { tile = frozen_tile_duplicate } })
    --
end
