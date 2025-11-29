local module = {}

local memory = {}

--- @param key string
---
--- @param value any
---
function module.set(key, value)
    --
    memory[key] = value
end

--- @param key string
---
--- @return any
---
function module.get(key)
    --
    return memory[key]
end

return module
