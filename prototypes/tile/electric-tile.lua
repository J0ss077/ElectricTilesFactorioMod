data:extend({
    {
        type = "tile",

        name = "electric-tile",

        subgroup = "artificial-tiles",

        --// DRAWING SECTION

        layer = 21,

        needs_correction = false,

        layer_group = "ground-artificial",

        decorative_removal_probability = 1.0,

        map_color = { r = 90, g = 90, b = 90 },

        --// MODIFIERS SECTION

        walking_speed_modifier = 1.4,

        vehicle_friction_modifier = 0.8,

        --// ADVANCED SECTION

        collision_mask = { layers = { ground_tile = true } },

        minable = { mining_time = 0.10, results = { { type = "item", name = "electric-tile", amount = 1 } } },

        --// VISUALS SECTION

        variants = {

            material_background = { picture = "__electric-tiles__/graphics/terrain/electric-tile/electric-tile.png", scale = 0.5, count = 8 },

            transition = {

                overlay_layout = {

                    inner_corner = { spritesheet = "__electric-tiles__/graphics/terrain/electric-tile/electric-tile-inner-corner.png", scale = 0.5, count = 16 },

                    outer_corner = { spritesheet = "__electric-tiles__/graphics/terrain/electric-tile/electric-tile-outer-corner.png", scale = 0.5, count = 08 },

                    u_transition = { spritesheet = "__electric-tiles__/graphics/terrain/electric-tile/electric-tile-u.png", scale = 0.5, count = 08 },

                    o_transition = { spritesheet = "__electric-tiles__/graphics/terrain/electric-tile/electric-tile-o.png", scale = 0.5, count = 04 },

                    side = { spritesheet = "__electric-tiles__/graphics/terrain/electric-tile/electric-tile-side.png", scale = 0.5, count = 16 }
                },

                mask_layout = {

                    inner_corner = { spritesheet = "__electric-tiles__/graphics/terrain/electric-tile/electric-tile-inner-corner-mask.png", scale = 0.5, count = 16 },

                    outer_corner = { spritesheet = "__electric-tiles__/graphics/terrain/electric-tile/electric-tile-outer-corner-mask.png", scale = 0.5, count = 08 },

                    u_transition = { spritesheet = "__electric-tiles__/graphics/terrain/electric-tile/electric-tile-u-mask.png", scale = 0.5, count = 08 },

                    o_transition = { spritesheet = "__electric-tiles__/graphics/terrain/electric-tile/electric-tile-o-mask.png", scale = 0.5, count = 04 },

                    side = { spritesheet = "__electric-tiles__/graphics/terrain/electric-tile/electric-tile-side-mask.png", scale = 0.5, count = 16 }
                }
            }
        },

        --// SOUNDS SECTION

        walking_sound = {

            advanced_volume_control = {

                fades = {

                    fade_in = {

                        curve_type = "cosine",

                        from = { control = 0.3, volume_percentage = 0 },

                        to = { control = 0.6, volume_percentage = 100 },
                    }
                }
            },

            variations = {

                { filename = "__electric-tiles__/sounds/walking/electric-tile-01.ogg", volume = 0.5 },

                { filename = "__electric-tiles__/sounds/walking/electric-tile-02.ogg", volume = 0.5 },

                { filename = "__electric-tiles__/sounds/walking/electric-tile-03.ogg", volume = 0.5 },

                { filename = "__electric-tiles__/sounds/walking/electric-tile-04.ogg", volume = 0.5 },

                { filename = "__electric-tiles__/sounds/walking/electric-tile-05.ogg", volume = 0.5 },

                { filename = "__electric-tiles__/sounds/walking/electric-tile-06.ogg", volume = 0.5 },

                { filename = "__electric-tiles__/sounds/walking/electric-tile-07.ogg", volume = 0.5 },

                { filename = "__electric-tiles__/sounds/walking/electric-tile-08.ogg", volume = 0.5 },

                { filename = "__electric-tiles__/sounds/walking/electric-tile-09.ogg", volume = 0.5 },

                { filename = "__electric-tiles__/sounds/walking/electric-tile-10.ogg", volume = 0.5 },

                { filename = "__electric-tiles__/sounds/walking/electric-tile-11.ogg", volume = 0.5 },
            }
        },

        driving_sound = {

            fade_ticks = 6.0,

            sound = {

                volume = 0.8,

                advanced_volume_control = {

                    fades = {

                        fade_in = {

                            curve_type = "cosine",

                            from = { control = 0.3, volume_percentage = 0 },

                            to = { control = 0.6, volume_percentage = 100 },
                        }
                    }
                },

                filename = "__electric-tiles__/sounds/driving/vehicle-surface-electric-tile.ogg"
            }
        },

        build_sound = {

            large = {

                variations = {

                    { filename = "__electric-tiles__/sounds/building/large/build-electric-tile-large-1.ogg", volume = 0.5 },

                    { filename = "__electric-tiles__/sounds/building/large/build-electric-tile-large-2.ogg", volume = 0.5 },

                    { filename = "__electric-tiles__/sounds/building/large/build-electric-tile-large-3.ogg", volume = 0.5 },

                    { filename = "__electric-tiles__/sounds/building/large/build-electric-tile-large-4.ogg", volume = 0.5 },

                    { filename = "__electric-tiles__/sounds/building/large/build-electric-tile-large-5.ogg", volume = 0.5 },

                    { filename = "__electric-tiles__/sounds/building/large/build-electric-tile-large-6.ogg", volume = 0.5 },
                }
            },

            medium = {

                variations = {

                    { filename = "__electric-tiles__/sounds/building/medium/build-electric-tile-medium-1.ogg", volume = 0.5 },

                    { filename = "__electric-tiles__/sounds/building/medium/build-electric-tile-medium-2.ogg", volume = 0.5 },

                    { filename = "__electric-tiles__/sounds/building/medium/build-electric-tile-medium-3.ogg", volume = 0.5 },

                    { filename = "__electric-tiles__/sounds/building/medium/build-electric-tile-medium-4.ogg", volume = 0.5 },

                    { filename = "__electric-tiles__/sounds/building/medium/build-electric-tile-medium-5.ogg", volume = 0.5 },

                    { filename = "__electric-tiles__/sounds/building/medium/build-electric-tile-medium-6.ogg", volume = 0.5 },
                }
            },

            small = {

                variations = {

                    { filename = "__electric-tiles__/sounds/building/small/build-electric-tile-small-1.ogg", volume = 0.4 },

                    { filename = "__electric-tiles__/sounds/building/small/build-electric-tile-small-2.ogg", volume = 0.4 },

                    { filename = "__electric-tiles__/sounds/building/small/build-electric-tile-small-3.ogg", volume = 0.4 },

                    { filename = "__electric-tiles__/sounds/building/small/build-electric-tile-small-4.ogg", volume = 0.4 },

                    { filename = "__electric-tiles__/sounds/building/small/build-electric-tile-small-5.ogg", volume = 0.4 },

                    { filename = "__electric-tiles__/sounds/building/small/build-electric-tile-small-6.ogg", volume = 0.4 },
                }
            }
        },

        mined_sound = {

            aggregation = { count_already_playing = true, max_count = 2, remove = true },

            variations = { { filename = "__electric-tiles__/sounds/mining/deconstruct-electric-tile.ogg", volume = 0.8 } }
        }
    }
})
