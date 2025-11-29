local data_loader = require("scripts.unique.data-loader")

local module = {}

function module.init()
    --
    module.check_storage_integrity() -- run integrity check on init
end

function module.load()
    --
end

--- Maintains the save integrity
---
function module.check_storage_integrity()
    --
    module.set("base-caching-chunks", module.get("base-caching-chunks") or {})
    --
    module.set("long-caching-chunks", module.get("long-caching-chunks") or {})
end

--- @param key string
---
--- @param value any
---
function module.set(key, value)
    --
    storage[key] = value
end

--- @param key string
---
--- @return any
---
function module.get(key)
    --
    return storage[key]
end

return module
