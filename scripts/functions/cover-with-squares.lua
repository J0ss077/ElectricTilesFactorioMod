--- @param original table
---
--- @return table -- resp
---
return function(original)
    --
    if #original == 0 then return {} end -- avoid empty mtx

    local matrix_size = { x = #original, y = #original[1] }

    -------------------------------------------------------

    local matrix = {}

    for x = 1, matrix_size.x, 1 do
        --
        matrix[x] = {} ---- column

        for y = 1, matrix_size.y, 1 do matrix[x][y] = original[x][y] end
        --
    end

    local function unfill(mx, my, msize)
        --
        for y = my, my + msize - 1, 1 do
            --
            for x = mx, mx + msize - 1, 1 do
                --
                matrix[x][y] = 0 -- clean mt
                --
            end
            --
        end
        --
    end

    local function opportunity(mx, my, msize)
        --
        local y_bound = my + msize

        local x_bound = mx + msize

        if y_bound > matrix_size.y then return false end

        if x_bound > matrix_size.x then return false end

        for y = my, y_bound, 1 do if matrix[x_bound][y] == 0 then return false end end

        for x = mx, x_bound, 1 do if matrix[x][y_bound] == 0 then return false end end

        return true
        --
    end

    local squares = {}

    for y = 1, matrix_size.y, 1 do
        --
        for x = 1, matrix_size.x, 1 do
            --
            if matrix[x][y] == 1 then
                --
                local size = 1 -- min

                while opportunity(x, y, size) do size = size + 1 end

                table.insert(squares, { x = x, y = y, size = size })

                unfill(x, y, size)
                --
            end
            --
        end
        --
    end

    return squares
    --
end
