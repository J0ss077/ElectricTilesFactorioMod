local internal = {
    --
    getInterfaceVersion = require("remotes.data-stage.get-interface-version"),
    --
    adaptTilePrototype = require("remotes.data-stage.adapt-tile-prototype"),
    --
    getItemPrefix = require("remotes.data-stage.get-item-prefix"),
    --
    getTilePrefix = require("remotes.data-stage.get-tile-prefix"),
    --
}

ElectricTilesDataInterface = setmetatable({}, {
    --
    __index = function(t, k)
        --
        local value = internal[k]

        if value ~= nil then
            --
            return value
            --
        else
            --
            error("This table doesn't contain that key.", 2)
            --
        end
        --
    end,

    __newindex = function(t, k, v)
        --
        error("You cannot do that.", 2)
        --
    end,

    __metatable = false
    --
})
