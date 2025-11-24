if not mods["space-age"] then return end

local definitions = require("scripts.var.definitions")

local collection = {
    --
    { item = "stone-brick",             tile = "stone-path" },
    --
    { item = "concrete",                tile = "concrete" },
    --
    { item = "hazard-concrete",         tile = "hazard-concrete-left" },
    --
    { item = "hazard-concrete",         tile = "hazard-concrete-right" },
    --
    { item = "refined-concrete",        tile = "refined-concrete" },
    --
    { item = "refined-hazard-concrete", tile = "refined-hazard-concrete-left" },
    --
    { item = "refined-hazard-concrete", tile = "refined-hazard-concrete-right" },
}

for __, objects in ipairs(collection) do
    --
    local tile_item_name = definitions.item_prefix .. objects.item

    local tile_reference = data.raw.tile[definitions.tile_prefix .. objects.tile]

    local frozen_duplicate = table.deepcopy(data.raw.tile["frozen-" .. objects.tile])

    ---------------------------------------------------------------------------------

    tile_reference.frozen_variant = definitions.tile_prefix .. frozen_duplicate.name

    frozen_duplicate.placeable_by = { item = tile_item_name, count = 1 }

    frozen_duplicate.layer = frozen_duplicate.layer + 64

    frozen_duplicate.minable.result = tile_item_name

    frozen_duplicate.thawed_variant = tile_reference.name

    -----------------------------------------------------

    ElectricTilesDataInterface.modTilePrototypes({ { tile = frozen_duplicate } })
    --
    --
end
