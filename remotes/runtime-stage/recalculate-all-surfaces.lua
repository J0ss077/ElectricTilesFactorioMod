local recalculate_all_surfaces_fun = require("scripts.functions.recalculate-all-surfaces")

return function(_data_)
    --
    recalculate_all_surfaces_fun(_data_)

    return true -- works like a sub-mask
    --
end
