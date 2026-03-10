local remotes = {
    {
        name = "F077ET-recalculateAllSurfaces",
        --
        description = "recalculates all surfaces in the game",
        --
        action = require("scripts.remote.console.__recalculate-all-surfaces")
    },
    {
        name = "F077ET-recalculateLookingSurface",
        --
        description = "recalculates the surface the player is 'looking'",
        --
        action = require("scripts.remote.console.__recalculate-looking-surface")
    },
}

return remotes
