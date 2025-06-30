local temporals = require("scripts.modules.temporals")

------------------------------------------------------

local internal

--- @return boolean
---
local function count_down()
    --
    if not internal.base_enabled then return false end

    local forc_predicted_tick = internal.forc_tick - 1

    local base_predicted_tick = internal.base_tick - 1

    if forc_predicted_tick > 0 and base_predicted_tick > 0 then
        --
        internal.forc_tick = forc_predicted_tick

        internal.base_tick = base_predicted_tick

        return false
        --
    else
        --
        internal.base_enabled = false

        internal.forc_enabled = false

        internal.base_tick = 0

        internal.forc_tick = 0

        if base_predicted_tick < 0 or forc_predicted_tick < 0 then
            --
            return false
            --
        else
            --
            return true
            --
        end
        --
    end
    --
end

local function restart()
    --
    if not internal.base_enabled then
        --
        internal.base_enabled = true

        internal.forc_enabled = true

        internal.base_tick = temporals.get("update-delay") * 01

        internal.forc_tick = temporals.get("update-delay") * 10
        --
    else
        --
        internal.base_tick = temporals.get("update-delay")
        --
    end
    --
end

internal = {
    --
    base_enabled = false,
    --
    forc_enabled = false,
    --
    base_tick = 0,
    --
    forc_tick = 0,
    --
    count_down = count_down,
    --
    restart = restart,
}

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
