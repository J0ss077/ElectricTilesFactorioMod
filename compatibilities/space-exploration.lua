if not mods["space-exploration"] then return end

local common_utils = require("scripts.lib.common-utils")

local carrier = data.raw["mod-data"]["F077ET-data-carrier"]

local data_util = require("__space-exploration__.data_util")

common_utils.combine_arrays(carrier.data["list-allowed-tiles"] --[[@as table]], {
    --
    data_util.mod_prefix .. "space-platform-scaffold",
    --
    data_util.mod_prefix .. "space-platform-plating",
})
