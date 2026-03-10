if not mods["Dectorio"] or not DECT.ENABLED["painted-concrete"] then return end

local definitions = require("scripts.var.definitions")

--// AUX Vars/Structures

local others = { use_default_recipe = true, technologies = { "dect-concrete-paint" } }

local subgroup00 = data.raw["item-subgroup"][definitions.item_prefix .. "terrain"]

--// Hazard Tiles

local subgroup01 = {
    --
    type = "item-subgroup",
    --
    name = subgroup00.name .. "-dect-hazards",
    --
    group = "dectorio",
    --
    order = subgroup00.order .. "-aa01[dect-hazards]"
}

local subgroup02 = {
    --
    type = "item-subgroup",
    --
    name = subgroup00.name .. "-dect-refined-hazards",
    --
    group = "dectorio",
    --
    order = subgroup00.order .. "-aa02[dect-refined-hazards]"
}

data:extend({ subgroup01, subgroup02 })

local hazards = {
    --
    { subgroup = subgroup01.name, paint = "dect-paint-" },
    --
    { subgroup = subgroup02.name, paint = "dect-paint-refined-" },
}

for i0, variant in pairs(DECT.CONFIG.PAINT_VARIANTS) do
    --
    for i1, hazard in ipairs(hazards) do
        --
        local t_left = table.deepcopy(data.raw.tile[hazard.paint .. variant.name .. "-left"])
        --
        local t_righ = table.deepcopy(data.raw.tile[hazard.paint .. variant.name .. "-right"])

        t_left.next_direction = definitions.tile_prefix .. t_righ.name

        t_righ.next_direction = definitions.tile_prefix .. t_left.name

        local item = table.deepcopy(data.raw.item[hazard.paint .. variant.name])

        item.subgroup = hazard.subgroup

        -------------------------------
        -------------------------------

        t_righ.placeable_by = { item = definitions.item_prefix .. item.name, count = 1 }

        t_righ.minable.result = t_righ.placeable_by.item

        ElectricTilesDataInterface.modTilePrototypes({ { tile = t_left, item = item, others = others }, { tile = t_righ } })
        --
        --
    end
end

--// Colored Refined Concretes

local subgroup03 = {
    --
    type = "item-subgroup",
    --
    name = subgroup00.name .. "-dect-colored",
    --
    group = "dectorio",
    --
    order = subgroup00.order .. "-aa03[dect-colored]"
}

data:extend({ subgroup03 })

for i0, color in pairs(DECT.CONFIG.BASE_COLORS) do
    --
    local tile = data.raw.tile[color.name .. "-refined-concrete"]

    -------------------------------------------------------------
    -------------------------------------------------------------

    local item = table.deepcopy(data.raw.item["dect-" .. color.name .. "-refined-concrete"])

    item.subgroup = subgroup03.name

    ElectricTilesDataInterface.modTilePrototypes({ { tile = tile, item = item, others = others } })
    --
    --
end
