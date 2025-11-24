data:extend({
    {
        type = "string-setting",
        name = "F077ET-chunk-subdivision",
        setting_type = "runtime-global",
        default_value = "32x32",
        allowed_values = { "32x32", "16x16", "8x8" },
        order = "a",
    },
    {
        type = "string-setting",
        name = "F077ET-base-update-delay",
        setting_type = "runtime-global",
        default_value = "0.75 seconds",
        allowed_values = { "0.50 seconds", "0.75 seconds", "1.00 seconds" },
        order = "b",
    },
    {
        type = "string-setting",
        name = "F077ET-long-update-delay",
        setting_type = "runtime-global",
        default_value = "5.00 seconds",
        allowed_values = { "2.50 seconds", "5.00 seconds", "7.50 seconds" },
        order = "c",
    },
    {
        type = "bool-setting",
        name = "F077ET-debug-mode",
        setting_type = "startup",
        default_value = false,
        order = "d",
    },
})
