local custom_definitions = require("definitions")

--local carrier = data.raw["mod-data"]["F077ET-data-carrier"]

local copper_wire_icon = "__electric-tiles__/graphics/icons/copper-wire.png"

local copper_wire_icon_scal = 0.50

local copper_wire_icon_move = 0.50

----------------------------------

local default_tile = {
    --
    type = "tile",
    --
    order = "a[base]",
    --
    minable = { mining_time = 00.10, result = "" }
    --
}

local default_item = {
    --
    type = "item",
    --
    order = "a[base]",
    --
    place_as_tile = {
        --
        result = "",
        --
        condition_size = 1,
        --
        condition = { layers = { water_tile = true } }
        --
    },
    --
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
    --
}

local default_others = {
    --
    result_amount = 1,
    --
    use_default_recipe = false,
    --
    add_copper_wire_icon = true,
    --
}

return function(_meta_)
    --
    local _data_ = _meta_ or {}

    -- TILE PHASE (REQUIRED)

    local new_tile_prototype = table.deepcopy(default_tile)

    for name, value in pairs(table.deepcopy(_data_.tile)) do
        --
        new_tile_prototype[name] = value
        --
    end

    new_tile_prototype.localised_name = new_tile_prototype.localised_name or { "tile-name." .. _data_.tile.name }

    new_tile_prototype.localised_name = { "", new_tile_prototype.localised_name, " (", { "item-name.__upper_case_electric__" }, ")" }

    new_tile_prototype.name = custom_definitions.tile_prefix .. new_tile_prototype.name

    new_tile_prototype.order = new_tile_prototype.order .. "-z[electric-variant]"

    data:extend({ new_tile_prototype })

    -- OTHERS VALUES (OPTIONAL)

    local other_data = table.deepcopy(default_others)

    if _data_.others ~= nil then
        --
        for name, value in pairs(table.deepcopy(_data_.others)) do
            --
            other_data[name] = value
            --
        end
        --
    end

    -- ITEM PHASE (OPTIONAL)

    if _data_.item ~= nil then
        --
        local new_item_prototype = table.deepcopy(default_item)

        for name, value in pairs(table.deepcopy(_data_.item)) do
            --
            new_item_prototype[name] = value
            --
        end

        new_item_prototype.localised_name = new_item_prototype.localised_name or { "item-name." .. _data_.item.name }

        new_item_prototype.localised_name = { "", new_item_prototype.localised_name, " (", { "item-name.__upper_case_electric__" }, ")" }

        new_item_prototype.name = custom_definitions.item_prefix .. new_item_prototype.name

        new_item_prototype.order = new_item_prototype.order .. "-z[electric-variant]"

        new_item_prototype.place_as_tile.result = new_tile_prototype.name

        -----------------------------------------------------------

        new_tile_prototype.minable.result = new_item_prototype.name

        new_tile_prototype.placeable_by = { count = 1, item = new_item_prototype.name }

        -------------------------------------------------------------------------------

        local icons = {}

        if new_item_prototype.icons then -- you probably use multiple icons
            --
            icons = table.deepcopy(new_item_prototype.icons)
            --
        elseif new_item_prototype.icon then -- you probably use ONLY one icon
            --
            table.insert(icons, { icon = new_item_prototype.icon, icon_size = new_item_prototype.icon_size or 64, draw_background = true, scale = 0.5 })
            --
        end

        if other_data.add_copper_wire_icon == true then
            --
            local base_icon_size = icons[1].icon_size or 64

            table.insert(icons, {

                icon_size = 64,

                floating = true,

                draw_background = false,

                icon = copper_wire_icon,

                scale = (base_icon_size * copper_wire_icon_scal) / 128,

                shift = {

                    -((base_icon_size - copper_wire_icon_scal * base_icon_size) / 2) * copper_wire_icon_move,

                    -((base_icon_size - copper_wire_icon_scal * base_icon_size) / 2) * copper_wire_icon_move,

                },
                --
            })
            --
        end

        new_item_prototype.icon = nil

        new_item_prototype.icons = icons

        new_item_prototype.icon_size = nil

        data:extend({ new_item_prototype })

        -- RECIPE PHASE (OPTIONAL)

        if _data_.recipe ~= nil or other_data.use_default_recipe then
            --
            local new_recipe_prototype = table.deepcopy(default_recipe)

            if _data_.recipe ~= nil then
                --
                for name, value in pairs(table.deepcopy(_data_.recipe)) do
                    --
                    new_recipe_prototype[name] = value
                    --
                end
                --
            end

            new_recipe_prototype.name = new_item_prototype.name

            new_recipe_prototype.results = { { type = "item", name = new_item_prototype.name, amount = other_data.result_amount } }

            new_recipe_prototype.ingredients = new_recipe_prototype.ingredients or {
                --
                { type = "item", name = _data_.item.name, amount = 1 },
                --
                { type = "item", name = "copper-cable",   amount = 1 },
                --
                { type = "item", name = "iron-stick",     amount = 1 },
                --
            }

            data:extend({ new_recipe_prototype })

            -- TECHNOLOGY PHASE (OPTIONAL)

            if not new_recipe_prototype.enabled then
                --
                local techs = _data_.technology or { "electric-tiles-tech" }

                for __, name in ipairs(techs) do
                    --
                    if data.raw.technology[name].effects == nil then data.raw.technology[name].effects = {} end

                    table.insert(data.raw.technology[name].effects, { type = "unlock-recipe", recipe = new_recipe_prototype.name })
                    --
                end
                --
            end
            --
        end
        --
    end

    -- SAVE PHASE (FINAL)

    --carrier.data["allowed-tiles"][new_tile_prototype.name] = true

    return true
    --
end
