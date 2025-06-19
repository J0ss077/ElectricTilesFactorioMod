local module = {}

local storage = {}

function module.set(name, value)
    --
    storage[name] = value
    --
end

function module.get(name)
    --
    return storage[name]
    --
end

return module
