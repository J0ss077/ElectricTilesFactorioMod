local module = {}

local storag = {}

--- @param name string
---
--- @param value any
---
function module.set(name, value)
    --
    storag[name] = value
end

--- @param name string
---
--- @return any
---
function module.get(name)
    --
    return storag[name]
end

return module
