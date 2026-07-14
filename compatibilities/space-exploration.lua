if not mods["space-exploration"] then return end

local _carrier = data.raw["mod-data"]["F077ET-data-carrier"]

local data_util = require("__space-exploration__.data_util")

require("scripts.lib.common-utils").combine_arrays(_carrier.data["list-allowed-tiles"]--[[@as table]], {
    --
    data_util.mod_prefix .. "space-platform-scaffold",
    --
    data_util.mod_prefix .. "space-platform-plating",
})
