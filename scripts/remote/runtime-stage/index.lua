local remotes = {
    --
    recalculateAllSurfaces = require("scripts.remote.runtime-stage.__recalculate-all-surfaces"),
    --
    getInterfaceVersion = require("scripts.remote.runtime-stage.__get-interface-version"),
    --
    recalculateSurface = require("scripts.remote.runtime-stage.__recalculate-surface"),
    --
    getItemPrefix = require("scripts.remote.runtime-stage.__get-item-prefix"),
    --
    getTilePrefix = require("scripts.remote.runtime-stage.__get-tile-prefix"),
}

return remotes
