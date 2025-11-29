local definitions = require("scripts.var.definitions")
local common_utils = require("scripts.lib.common-utils")

local carrier = data.raw["mod-data"]["F077ET-data-carrier"]

local copper_wire_icon = "__electric-tiles__/graphics/icon/copper-wire.png"
local copper_wire_icon_percent_shift = { x = -0.50, y = -0.50 }
local copper_wire_icon_percent_scale = 0.50

local default_tile = {
    --
    type = "tile",
    --
    order = "a[base]",
    --
    minable = { mining_time = 0.10, result = nil }
}

local default_item = {
    --
    type = "item",
    --
    order = "a[base]",
    --
    subgroup = definitions.item_prefix .. data.raw["item-subgroup"]["terrain"].name,
    --
    place_as_tile = {
        --
        result = nil,
        --
        condition_size = 1,
        --
        condition = { layers = { water_tile = true } }
    }
}

local default_recipe = {
    --
    type = "recipe",
    --
    enabled = false,
    --
    auto_recycle = true,
    --
    category = "advanced-crafting"
}

local default_others = {
    --
    result_amount = 1,
    --
    use_default_recipe = false,
    --
    add_copper_wire_icon = true,
    --
    technologies = { "F077ET-technology" }
}

--- @param prototype table
---
--- @param base_localization string
---
--- @param post_localization string
---
local function assign_prototype_localised_name(prototype, base_localization, post_localization)
    --
    if not prototype.localised_name then prototype.localised_name = { base_localization } end
    --
    prototype.localised_name = { "", prototype.localised_name, " ", { post_localization } }
end

local module = {}

function module.make_electric_variant(base_data)
    --
    for __, object in ipairs(base_data) do
        --
        if type(object) ~= "table" then error("(custom error) all data must be tables !!") end
    end

    local others = common_utils.combine_dictionaries(default_others, base_data.others or {}, true)

    ----------------------------------------------------------------------------------------------
    ----------------------------------------------------------------------------------------------

    local new_tile = common_utils.combine_dictionaries(default_tile, base_data.tile or {}, true)

    new_tile.name = definitions.tile_prefix .. base_data.tile.name

    assign_prototype_localised_name(new_tile, "tile-name." .. base_data.tile.name, "tile-name.F077ET-tile-postfix")

    new_tile.order = base_data.tile.order .. "-e[electric-variant]"

    data:extend({ new_tile })

    -------------------------------------------------------------------------------
    table.insert(carrier.data["list-allowed-tiles"] --[[@as table]], new_tile.name)
    -------------------------------------------------------------------------------

    if not base_data.item then return end

    local new_item = common_utils.combine_dictionaries(default_item, base_data.item or {}, true)

    new_item.name = definitions.item_prefix .. base_data.item.name

    assign_prototype_localised_name(new_item, "item-name." .. base_data.item.name, "item-name.F077ET-item-postfix")

    new_item.order = base_data.item.order .. "-e[electric-variant]"

    new_item.place_as_tile.result = new_tile.name

    ---------------------------------------
    new_tile.minable.result = new_item.name

    new_tile.placeable_by = { item = new_item.name, count = 1 }
    -----------------------------------------------------------

    common_utils.parse_item_icons(new_item, true)

    local icon_size = new_item.icons[1].icon_size or 64.0

    table.insert(new_item.icons, {
        --
        icon = copper_wire_icon,
        --
        icon_size = 64,
        --
        floating = true,
        --
        draw_background = false,
        --
        scale = icon_size / 64 * 0.50 * copper_wire_icon_percent_scale,
        --
        shift = {
            --
            icon_size / 4 * copper_wire_icon_percent_shift.x,
            --
            icon_size / 4 * copper_wire_icon_percent_shift.y,
        },
    })

    data:extend({ new_item })

    if not (base_data.recipe or others.use_default_recipe) then return end

    local new_recipe = common_utils.combine_dictionaries(default_recipe, base_data.recipe or {}, true)

    new_recipe.name = new_item.name

    new_recipe.ingredients = new_recipe.ingredients or {
        --
        { type = "item", name = base_data.item.name, amount = 1 },
        --
        { type = "item", name = "copper-cable",      amount = 1 },
        --
        { type = "item", name = "iron-stick",        amount = 1 },
    }

    new_recipe.results = { { type = "item", name = new_item.name, amount = others.result_amount } }

    data:extend({ new_recipe })

    if not new_recipe.enabled then
        --
        for __, tech in ipairs(others.technologies) do
            --
            if data.raw["technology"][tech].effects == nil then data.raw["technology"][tech].effects = {} end
            --
            table.insert(data.raw["technology"][tech].effects, { type = "unlock-recipe", recipe = new_recipe.name })
        end
    end
end

return module
