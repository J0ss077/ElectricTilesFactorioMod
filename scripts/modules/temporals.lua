local module = {}

local storage = {}

--- @param name string
---
--- @param value any
---
function module.set(name, value)
    --
    storage[name] = value
    --
end

--- @param name string
---
--- @return any
---
function module.get(name)
    --
    return storage[name]
    --
end

return module
