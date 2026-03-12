if not mods["Krastorio2"] then return end

local others = { use_default_recipe = true, technologies = { "kr-reinforced-plates" } }

ElectricTilesDataInterface.modTilePrototypes({
    {
        tile = data.raw.tile["kr-black-reinforced-plate"],
        item = data.raw.item["kr-black-reinforced-plate"],
        others = others
    },
    {
        tile = data.raw.tile["kr-white-reinforced-plate"],
        item = data.raw.item["kr-white-reinforced-plate"],
        others = others
    },
})
