local utils = require("scripts.modules.utils")

local temps = require("scripts.modules.temps")

local base_proxy = {

    type = "electric-pole",

    maximum_wire_distance = 0,

    draw_copper_wires = false,

    draw_circuit_wires = false,

    remove_decoratives = "false",

    create_ghost_on_death = false,

    auto_connect_up_to_n_wires = 0,

    collision_mask = { layers = {} },

    protected_from_tile_building = false,

    rewire_neighbours_when_destroying = false,

    flags = { "not-blueprintable", "not-on-map", "placeable-off-grid" },

    connection_points = { { shadow = { copper = { 0, 0 } }, wire = { copper = { 0, 0 } } } }
}

local debug_proxy = {

    draw_copper_wires = true,

    minable = { mining_time = 0.01 },

    drawing_box_vertical_extension = 2.3,

    selection_box = { { -0.5, -0.5 }, { 0.5, 0.5 } },

    radius_visualisation_picture = {

        filename = "__electric-tiles__/graphics/entity/electric-proxy/electric-proxy-radius-visualization.png",

        priority = "extra-high-no-scale",

        height = 12,

        width = 12
    },

    pictures = {

        layers = {

            {
                filename = "__electric-tiles__/graphics/entity/electric-proxy/electric-proxy.png",

                shift = { 0.109375, -1.375000 },

                priority = "extra-high",

                direction_count = 1,

                height = 252,

                scale = 0.50,

                width = 0084,
            },
            {
                filename = "__electric-tiles__/graphics/entity/electric-proxy/electric-proxy-shadow.png",

                shift = { 1.765625, -0.031250 },

                priority = "extra-high",

                draw_as_shadow = true,

                direction_count = 1,

                height = 64,

                scale = 0.5,

                width = 280,
            },
        }
    },

    water_reflection = {

        orientation_to_variation = false,

        rotate = false, -- dont change !!

        pictures = {

            filename = "__electric-tiles__/graphics/entity/electric-proxy/electric-proxy-reflection.png",

            priority = "extra-high",

            shift = { 0, 1.71875 },

            variation_count = 1,

            height = 28,

            width = 12,

            scale = 5,
        },
    },

    connection_points = { { shadow = { copper = { 3.578125, -0.203125 } }, wire = { copper = { 0.234375, -3.109375 } } } }
}

if temps.get("debug-mode") then
    --
    for key, value in pairs(debug_proxy) do
        --
        base_proxy[key] = value
        --
    end
    --
end

local prototypes = {}

for i = 0.5, temps.get("chunk-area-size") / 2, 0.5 do
    --
    local prototype = table.deepcopy(base_proxy) -- new

    prototype.name = utils.getProxyNameFromSupplyDistance(i)

    prototype.supply_area_distance = i -- dinamically generate

    table.insert(prototypes, prototype)
    --
end

data:extend(prototypes)
