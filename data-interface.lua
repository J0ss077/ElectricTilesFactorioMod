local remotes = require("scripts.remote.data-stage.index")

ElectricTilesDataInterface = setmetatable({}, {

    __index = function(table, key)
        --
        local value = remotes[key]

        if value then
            --
            return value
        else
            error("(custom error) key not found.")
        end
    end,

    __newindex = function(table, key, value)
        --
        error("(custom error) setting values is forbidden.")
    end,

    __metatable = false
    --
    --
})
