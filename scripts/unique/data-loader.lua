local common_utils = require("scripts.lib.common-utils")
local temp_storage = require("scripts.var.temp-storage")

local module = {}

function module.load_startup_settings()
    --
    temp_storage.set("debug-mode", settings.startup["F077ET-debug-mode"].value)
end

function module.load_runtime_settings()
    --
    local setting_001 = settings.global["F077ET-chunk-subdivision"].value

    if setting_001 == "8x8" then
        --
        temp_storage.set("chunk-area-size", 08.0)
        --
    elseif setting_001 == "16x16" then
        --
        temp_storage.set("chunk-area-size", 16.0)
        --
    elseif setting_001 == "32x32" then
        --
        temp_storage.set("chunk-area-size", 32.0)
    end

    local setting_002 = settings.global["F077ET-base-update-delay"].value

    if setting_002 == "0.50 seconds" then
        --
        temp_storage.set("base-update-delay", 30)
        --
    elseif setting_002 == "0.75 seconds" then
        --
        temp_storage.set("base-update-delay", 45)
        --
    elseif setting_002 == "1.00 seconds" then
        --
        temp_storage.set("base-update-delay", 60)
    end

    local setting_003 = settings.global["F077ET-long-update-delay"].value

    if setting_003 == "2.50 seconds" then
        --
        temp_storage.set("long-update-delay", 150)
        --
    elseif setting_003 == "5.00 seconds" then
        --
        temp_storage.set("long-update-delay", 300)
        --
    elseif setting_003 == "7.50 seconds" then
        --
        temp_storage.set("long-update-delay", 450)
    end
end

function module.load_temp_data()
    --
    local carrier = prototypes.mod_data["F077ET-data-carrier"]

    local dict_allowed_tiles = {}

    local proxies_names = {}

    for range = 0.5, 16.0, 0.5 do
        --
        table.insert(proxies_names, common_utils.proxyName_from_supplyDistance(range))
    end

    for __, name in ipairs(carrier.data["list-allowed-tiles"] --[[@as table]]) do
        --
        dict_allowed_tiles[name] = true
    end

    temp_storage.set("list-allowed-tiles", carrier.data["list-allowed-tiles"])

    temp_storage.set("dict-allowed-tiles", dict_allowed_tiles)

    temp_storage.set("proxies-names", proxies_names)
end

return module
