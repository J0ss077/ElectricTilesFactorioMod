local utilities = require("scripts.modules.utilities")

local custom_definitions = require("definitions")

--------------------------------------------

local internal

local sstorage

local function get_iterator()
    --
    local next_key = nil

    local next_val = nil

    return function()
        --
        next_key, next_val = next(sstorage, next_key)

        if next_key ~= nil then -- make sure
            --
            return next_key, next_val
            --
        end
        --
    end
    --
end

--- @param surface_name string
---
--- @param position TilePosition
---
--- @param mode custom_definitions.tiling_cache_operation
---
local function cache_tile(surface_name, position, mode) -- caching
    --
    if not sstorage[surface_name] then sstorage[surface_name] = {} end

    if not sstorage[surface_name][position.x] then sstorage[surface_name][position.x] = {} end

    --------------------------------------------------------------------------------------

    local target = sstorage[surface_name][position.x][position.y]

    if target == nil then
        --
        sstorage[surface_name][position.x][position.y] = mode
        --
    elseif target ~= mode then
        --
        if target == custom_definitions.tiling_cache_operation.undefined then
            --
            sstorage[surface_name][position.x][position.y] = mode
            --
        elseif target == custom_definitions.tiling_cache_operation.mining and mode == custom_definitions.tiling_cache_operation.building then
            --
            sstorage[surface_name][position.x][position.y] = nil
            --
        elseif target == custom_definitions.tiling_cache_operation.building and mode == custom_definitions.tiling_cache_operation.mining then
            --
            sstorage[surface_name][position.x][position.y] = nil
            --
        end
        --
    end
    --
end

local function reset_cache()
    --
    utilities.deleteTableCorrectly(sstorage, false)

    sstorage = {} -- completly remove trace of data
    --
end

internal = {
    --
    get_iterator = get_iterator,
    --
    reset_cache = reset_cache,
    --
    cache_tile = cache_tile,
}

sstorage = {}

return setmetatable({}, {
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
