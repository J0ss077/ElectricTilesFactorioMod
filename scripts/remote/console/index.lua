local remotes = {
    {
        name = "F077ET-recalculateAllSurfaces",
        --
        description = "recalculates all surfaces in the game",
        --
        action = require("scripts.remote.console.__recalculate-all-surfaces")
    }
}

return remotes
