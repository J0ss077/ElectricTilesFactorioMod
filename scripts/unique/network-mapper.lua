local module = {}

local function generate_ring_order(wiidth, height)
    -----
    local order = {}

    for radius = 0, math.max(wiidth, height) - 1 do
        --
        if radius == 0 then
            -----
            table.insert(order, { 0, 0 })
        else
            if radius < height then for x = 0, math.min(radius - 1, wiidth - 1) do table.insert(order, { x, radius }) end end
            if radius < wiidth then for y = 0, math.min(radius - 0, height - 1) do table.insert(order, { radius, y }) end end
        end
    end

    return order
    --
    --
end

local function can_grow(matrix, wiidth, height, x0, y0, size)
    -----
    local next_x = x0 + size
    local next_y = y0 + size

    if next_x >= wiidth or next_y >= height then return false end

    for y = y0, y0 + size - 1 do if not matrix[next_x][y] then return false end end
    for x = x0, x0 + size - 0 do if not matrix[x][next_y] then return false end end

    return true
    --
    --
end

local function build_cube(matrix, wiidth, height, x0, y0)
    --
    if not matrix[x0][y0] then return nil end

    local size = 1

    while can_grow(matrix, wiidth, height, x0, y0, size) do size = size + 1 end

    for     x = x0, x0 + size - 1 do
        for y = y0, y0 + size - 1 do
            --
            matrix[x][y] = false
            --
        end
    end

    return { x = x0 + 1, y = y0 + 1, size = size, neighbors = {} }
    --
    --
end

local function is_touching(x, y, cube)
    --
    local cx = cube.x - 1
    local cy = cube.y - 1

    local dx = math.max(cx - x, x - cx - cube.size + 1, 0)
    local dy = math.max(cy - y, y - cy - cube.size + 1, 0)

    return dx <= 1 and dy <= 1 and (dx + dy > 0)
    --
    --
end

function module.process_matrix(matrix, wiidth, height)
    -----
    local cubes = {}

    for i0, position in ipairs(generate_ring_order(wiidth, height)) do
        -----
        local x, y = position[1], position[2]

        if matrix[x][y] then
            -----
            local parent = nil

            for i1, registered_cube in ipairs(cubes) do
                --
                if is_touching(x, y, registered_cube) then parent = registered_cube break end
                --
            end

            local new_cube = build_cube(matrix, wiidth, height, x, y)

            if new_cube then
                --
                if parent then table.insert(parent.neighbors, { x = new_cube.x, y = new_cube.y }) end
                --
                table.insert(cubes, new_cube)
                --
            end
        end
    end

    return cubes
    --
    --
end

return module
