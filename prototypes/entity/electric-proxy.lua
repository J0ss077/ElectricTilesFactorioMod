local utilities = require("scripts.modules.utilities")

local temporals = require("scripts.modules.temporals")

local base_proxy = {

    type = "electric-pole",

    maximum_wire_distance = 0,

    draw_copper_wires = false,

    draw_circuit_wires = false,

    remove_decoratives = "false",

    create_ghost_on_death = false,

    hidden_in_factoriopedia = true,

    collision_mask = { layers = {} },

    protected_from_tile_building = false,

    rewire_neighbours_when_destroying = false,

    flags = { "not-blueprintable", "not-on-map", "placeable-off-grid" },

    radius_visualisation_picture = {
        --
        filename = "__electric-tiles__/graphics/entity/electric-proxy/electric-proxy-radius-visualization.png",
        --
        priority = "extra-high-no-scale",
        --
        height = 12,
        --
        width = 012,
        --
    },

    connection_points = {
        {
            shadow = { copper = { 3.578125, -0.203125 }, green = { 3.1406250, -0.031250 }, red = { 3.843750, -0.031250 } },
            wire   = { copper = { 0.234375, -3.109375 }, green = { -0.234375, -2.890625 }, red = { 0.671875, -2.796875 } }
        },
        {
            shadow = { copper = { 3.578125, -0.203125 }, green = { 3.0625000, -0.359375 }, red = { 3.593750, 0.1562500 } },
            wire   = { copper = { 0.234375, -3.109375 }, green = { -0.140625, -3.125000 }, red = { 0.421875, -2.609375 } }
        },
        {
            shadow = { copper = { 3.578125, -0.203125 }, green = { 3.3906250, -0.468750 }, red = { 3.250000, 0.1875000 } },
            wire   = { copper = { 0.234375, -3.109375 }, green = { 0.2031250, -3.218750 }, red = { 0.078125, -2.593750 } }
        },
        {
            shadow = { copper = { 3.578125, -0.203125 }, green = { 3.7187500, -0.359375 }, red = { 3.046875, 0.0156250 } },
            wire   = { copper = { 0.234375, -3.109375 }, green = { 0.5625000, -3.109375 }, red = { -0.18750, -2.734375 } }
        },
    },
}

local dbug_proxy = {

    draw_copper_wires = true,

    draw_circuit_wires = true,

    hidden_in_factoriopedia = false,

    minable = { mining_time = 0.01 },

    drawing_box_vertical_extension = 2.3,

    selection_box = { { -0.5, -0.5 }, { 0.5, 0.5 } },

    pictures = {

        layers = {

            {
                filename = "__electric-tiles__/graphics/entity/electric-proxy/electric-proxy.png",
                --
                shift = { 0.109375, -1.375000 },
                --
                priority = "extra-high",
                --
                direction_count = 4,
                --
                height = 252,
                --
                scale = 0.50,
                --
                width = 0084
            },
            {
                filename = "__electric-tiles__/graphics/entity/electric-proxy/electric-proxy-shadow.png",
                --
                shift = { 1.765625, -0.031250 },
                --
                priority = "extra-high",
                --
                draw_as_shadow = true,
                --
                direction_count = 4,
                --
                height = 64,
                --
                scale = 0.5,
                --
                width = 280
            },
        },
    },

    water_reflection = {

        orientation_to_variation = false,

        rotate = false, -- dont change !!

        pictures = {

            filename = "__electric-tiles__/graphics/entity/electric-proxy/electric-proxy-reflection.png",
            --
            priority = "extra-high",
            --
            shift = { 0, 1.71875 },
            --
            variation_count = 1,
            --
            height = 028,
            --
            width = 12,
            --
            scale = 5
        }
    }
}

if temporals.get("debug-mode") then
    --
    for key, value in pairs(dbug_proxy) do
        --
        base_proxy[key] = value
        --
    end
    --
end

local prototypes = {}

for i = 0.5, 16.0, 0.5 do
    --
    local prototype = table.deepcopy(base_proxy) ---- create new

    prototype.name = utilities.getProxyNameFromSupplyDistance(i)

    prototype.supply_area_distance = i --- dinamically generated

    table.insert(prototypes, prototype)
    --
end

data:extend(prototypes)
