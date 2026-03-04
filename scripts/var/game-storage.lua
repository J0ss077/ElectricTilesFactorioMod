local module = {}

function module.init()
    --
    module.check_storage_integrity() -- run integrity check on init
end

function module.load()
    --
    -- nothing for now ...
end

--- maintains the save integrity
---
function module.check_storage_integrity()
    --
    module.set("base-caching-chunks", module.get("base-caching-chunks") or { ["8x8"] = {}, ["16x16"] = {}, ["32x32"] = {} })
    module.set("long-caching-chunks", module.get("long-caching-chunks") or { ["8x8"] = {}, ["16x16"] = {}, ["32x32"] = {} })
    --
end

---------------------------------------------------------------
--------------------- CACHING METHOD --------------------------
---------------------------------------------------------------
---
--- cache = {
---     ["8x8"] = {
---         ["{surface_name}/{chunk_x}/{chunk_y}"] = true,
---         ["{surface_name}/{chunk_x}/{chunk_y}"] = true,
---         ...,
---         ...,
---     },
---     ["16x16"] = {
---         ["nauvis/1/1"] = true,
---         ["nauvis/2/2"] = true,
---         ...,
---         ...,
---     },
---     ...,
---     ...,
--- }
---
--- this method allows fast indexing of cached chunks based on chunk size:
---
---   x0 => chunk's X position: 0
---   y0 => chunk's Y position: 0
---
---------------------------------------------------------------
---------------------------------------------------------------

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
