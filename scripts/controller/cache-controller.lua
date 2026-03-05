local game_storage = require("scripts.var.game-storage")

local common_utils = require("scripts.lib.common-utils")

local module = {}

--- @param remove boolean
---
--- @param mode "base" | "long"
---
--- @param address? string
---
--- @param surface_name? string
---
--- @param chunk_position? ChunkPosition
---
--- @param chunk_subdivision? "x8" | "x16" | "x32"
---
local function process_chunk(remove, mode, address, surface_name, chunk_position, chunk_subdivision)
    --
    if not address then
        --
        if not surface_name or not chunk_position then error("(custom error) insufficient data to perform operation.") end
        --
        address = common_utils.chunkCacheAddress_from_chunkData(surface_name, chunk_position.x, chunk_position.y)
        --
    end

    chunk_subdivision = chunk_subdivision or settings.global["F077ET-chunk-subdivision"].value

    if remove then
        --
        game_storage.get(mode .. "-caching-chunks")[chunk_subdivision][address] = nil
        --
    else
        --
        local diff = mode == "base" and "long" or "base"
        --
        if game_storage.get(diff .. "-caching-chunks")[chunk_subdivision][address] then return end
        --
        game_storage.get(mode .. "-caching-chunks")[chunk_subdivision][address] = true
        --
    end
end

--- @param mode "base" | "long"
---
--- @param surface_name string
---
--- @param chunk_position ChunkPosition
---
function module.cache_chunk(mode, surface_name, chunk_position) process_chunk(false, mode, nil, surface_name, chunk_position) end

--- @param mode "base" | "long"
---
--- @param address string
---
--- @param chunk_subdivision? "x8" | "x16" | "x32"
---
function module.clear_chunk(mode, address, chunk_subdivision) process_chunk(true, mode, address, nil, nil, chunk_subdivision) end

return module
