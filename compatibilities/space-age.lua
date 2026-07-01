if not mods["space-age"] then return end

local definitions = require("scripts.var.definitions")

local le,ri = "left","right"

local collection = {
    --
    { item = "stone-brick", tile = "stone-path" },
    --
    { item = "concrete",        tile = "concrete" },
    { item = "hazard-concrete", tile = "hazard-concrete-" .. le },
    { item = "hazard-concrete", tile = "hazard-concrete-" .. ri },
    --
    { item = "refined-concrete",        tile = "refined-concrete" },
    { item = "refined-hazard-concrete", tile = "refined-hazard-concrete-" .. le },
    { item = "refined-hazard-concrete", tile = "refined-hazard-concrete-" .. ri },
}

for i0, objects in ipairs(collection) do
    --
    local tile_item_name = definitions.item_prefix .. objects.item

    local tile_reference = data.raw.tile[definitions.tile_prefix .. objects.tile]

    local frozn_duplic = table.deepcopy(data.raw.tile["frozen-" .. objects.tile])

    ----------------------------------------------------------------------------
    ----------------------------------------------------------------------------

    tile_reference.frozen_variant = definitions.tile_prefix .. frozn_duplic.name

    frozn_duplic.placeable_by = { item = tile_item_name, count = 1 }

    frozn_duplic.thawed_variant = tile_reference.name

    frozn_duplic.minable.result = tile_item_name

    --------------------------------------------
    --------------------------------------------

    ElectricTilesDataInterface.modTilePrototypes({ { tile = frozn_duplic } })
    --
    --
end
