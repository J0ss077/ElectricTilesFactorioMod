data:extend({
    {
        type = "string-setting",
        name = "electric-tiles-chunk-subdivision",
        setting_type = "runtime-global",
        default_value = "32x32",
        allowed_values = { "32x32", "16x16", "8x8" },
        order = "a"
    },
    {
        type = "string-setting",
        name = "electric-tiles-update-delay",
        setting_type = "runtime-global",
        default_value = "1 second",
        allowed_values = { "1 second", "0.75 seconds", "0.50 seconds" },
        order = "b"
    },
    {
        type = "bool-setting",
        name = "electric-tiles-debug-mode",
        setting_type = "startup",
        default_value = false,
        order = "c"
    }
})
