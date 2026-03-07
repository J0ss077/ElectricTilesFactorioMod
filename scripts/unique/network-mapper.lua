local module = {}

local grow_combinations = {

    right_top = { x = 1, y = 1 },
    --
    right_bottom = { x = 1, y = -1 },
    --
    left_top = { x = -1, y = 1 },
    --
    left_bottom = { x = -1, y = -1 },
}

--- @param matrix table
---
--- @param pos_x integer
---
--- @param pos_y integer
---
--- @param size integer
---
--- @param grow_combination table
---
--- @return table
---
local function can_grow(matrix, pos_x, pos_y, size, grow_combination)
    --
    local new_x = (grow_combination.x == -1) and (pos_x - 1) or pos_x
    local new_y = (grow_combination.y == -1) and (pos_y - 1) or pos_y

    if
        (new_x < 1 or new_y < 1) or
        (new_x + size > #matrix) or
        (new_y + size > #matrix)
    then
        --
        return { can = false, limit = true }
        --
    end

    local new_col_x = (grow_combination.x == 1) and (new_x + size) or (new_x)
    local new_row_y = (grow_combination.y == 1) and (new_y + size) or (new_y)

    for row = new_y, new_y + size - 0 do
        --
        if not matrix[new_col_x][row] then return { can = false } end
        --
    end

    for col = pos_x, pos_x + size - 1 do
        --
        if not matrix[col][new_row_y] then return { can = false } end
        --
    end

    return { can = true }
    --
end

--- @param matrix table
---
--- @param x integer
---
--- @param y integer
---
--- @return table
---
local function get_cube(matrix, x, y)
    --
    local cube = { x = x, y = y, size = 1, children = {}, touching_limits = false }

    for i0, combination in pairs(grow_combinations) do
        --
        while true do
            --
            local response = can_grow(matrix, cube.x, cube.y, cube.size, combination)

            if response.limit then cube.touching_limits = true end

            ----------------------------------
            if not response.can then break end
            ----------------------------------

            cube.size = cube.size + 1

            if combination.x == -1 then cube.x = cube.x - 1 end
            if combination.y == -1 then cube.y = cube.y - 1 end
            --
        end
    end

    for _X = cube.x, cube.x + cube.size - 1 do
        --
        for _Y = cube.y, cube.y + cube.size - 1 do
            --
            matrix[_X][_Y] = false
            --
        end
    end

    return cube
    --
end

--- @param matrix table
---
--- @param cube table
---
--- @return table
---
local function find_children(matrix, cube)
    --
    local border_X0 = cube.x - 1
    local border_Y0 = cube.y - 1
    --
    local border_X1 = cube.x + cube.size
    local border_Y1 = cube.y + cube.size

    if border_X0 >= 1 then
        --
        for _Y = math.max(border_Y0, 1), math.min(border_Y1, #matrix) do
            --
            if matrix[border_X0][_Y] then
                --
                table.insert(cube.children, find_children(matrix, get_cube(matrix, border_X0, _Y)))
                --
            end
        end
    end

    if border_X1 <= #matrix then
        --
        for _Y = math.max(border_Y0, 1), math.min(border_Y1, #matrix) do
            --
            if matrix[border_X1][_Y] then
                --
                table.insert(cube.children, find_children(matrix, get_cube(matrix, border_X1, _Y)))
                --
            end
        end
    end

    if border_Y0 >= 1 then
        --
        for _X = cube.x, cube.x + cube.size - 1 do
            --
            if matrix[_X][border_Y0] then
                --
                table.insert(cube.children, find_children(matrix, get_cube(matrix, _X, border_Y0)))
                --
            end
        end
    end

    if border_Y1 <= #matrix then
        --
        for _X = cube.x, cube.x + cube.size - 1 do
            --
            if matrix[_X][border_Y1] then
                --
                table.insert(cube.children, find_children(matrix, get_cube(matrix, _X, border_Y1)))
                --
            end
        end
    end

    return cube
    --
end

--- @param matrix table
---
--- @return table
---
function module.process_square_matrix(matrix)
    --
    local cubes = {}

    for _X, column in ipairs(matrix) do
        --
        for _Y, _value in ipairs(column) do
            --
            if _value then
                --
                table.insert(cubes, find_children(matrix, get_cube(matrix, _X, _Y)))
                --
            end
        end
    end

    return cubes
    --
end

return module
