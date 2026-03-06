local module = {}

--- @param matrix table
---
--- @param old_x integer
--- @param old_y integer
---
--- @param size integer
---
--- @param grow_x 1|-1
--- @param grow_y 1|-1
---
--- @return boolean
---
local function can_grow(matrix, old_x, old_y, size, grow_x, grow_y)
    --
    local new_x = grow_x == -1 and (old_x - 1) or old_x
    local new_y = grow_y == -1 and (old_y - 1) or old_y

    if new_x < 1 or new_y < 1 then return false end
    --
    if new_x + size > #matrix then return false end
    if new_y + size > #matrix then return false end

    local new_col_x = grow_x == 1 and (new_x + size) or new_x
    local new_row_y = grow_y == 1 and (new_y + size) or new_y

    for row = new_y, new_y + size - 0 do if not matrix[new_col_x][row] then return false end end
    for col = old_x, old_x + size - 1 do if not matrix[col][new_row_y] then return false end end

    return true
    --
    --
end

local grow_combinations = { { 1, 1 }, { 1, -1 }, { -1, 1 }, { -1, -1 } }

--- @param matrix table
---
--- @param x integer
--- @param y integer
---
--- @return table
---
local function get_cube(matrix, x, y)
    --
    local new_cube = { x = x, y = y, size = 1, children = {} }

    for i0, grow_combination in ipairs(grow_combinations) do
        --
        while can_grow(matrix, new_cube.x, new_cube.y, new_cube.size, grow_combination[1], grow_combination[2]) do
            --
            new_cube.size = new_cube.size + 1

            if grow_combinations[1] == -1 then new_cube.x = new_cube.x - 1 end
            if grow_combinations[2] == -1 then new_cube.y = new_cube.y - 1 end
        end
    end

    for iX = new_cube.x, new_cube.x + new_cube.size - 1 do
        --
        for iY = new_cube.y, new_cube.y + new_cube.size - 1 do
            --
            matrix[iX][iY] = false
        end
    end

    return new_cube
    --
    --
end

--- @param matrix table
---
--- @param cube table
---
--- @return table
---
local function try_find_children(matrix, cube)
    --
    local ringX0 = cube.x - 1
    local ringY0 = cube.y - 1
    --
    local ringX1 = cube.x + cube.size
    local ringY1 = cube.y + cube.size

    if ringX0 >= 1 then
        --
        for y = math.max(ringY0, 1), math.min(ringY1, #matrix) do
            --
            if matrix[ringX0][y] then
                --
                table.insert(cube.children, try_find_children(matrix, get_cube(matrix, ringX0, y)))
                --
            end
        end
    end

    if ringX1 <= #matrix then
        --
        for y = math.max(ringY0, 1), math.min(ringY1, #matrix) do
            --
            if matrix[ringX1][y] then
                --
                table.insert(cube.children, try_find_children(matrix, get_cube(matrix, ringX1, y)))
                --
            end
        end
    end

    if ringY0 >= 1 then
        --
        for x = math.max(cube.x, 1), math.min(cube.x + cube.size - 1, #matrix) do
            --
            if matrix[x][ringY0] then
                --
                table.insert(cube.children, try_find_children(matrix, get_cube(matrix, x, ringY0)))
                --
            end
        end
    end

    if ringY1 <= #matrix then
        --
        for x = math.max(cube.x, 1), math.min(cube.x + cube.size - 1, #matrix) do
            --
            if matrix[x][ringY1] then
                --
                table.insert(cube.children, try_find_children(matrix, get_cube(matrix, x, ringY1)))
                --
            end
        end
    end

    return cube
    --
    --
end

--- @param matrix table
---
--- @return table
---
function module.process_square_matrix(matrix)
    --
    local cubes = {}

    for iX, column in ipairs(matrix) do
        --
        for iY, tvalue in ipairs(column) do
            --
            if tvalue then
                --
                table.insert(cubes, try_find_children(matrix, get_cube(matrix, iX, iY)))
                --
            end
        end
    end

    return cubes
    --
    --
end

return module
