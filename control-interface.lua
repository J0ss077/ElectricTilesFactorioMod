remote.add_interface("ElectricTilesControlInterface", {
    --
    recalculateAllSurfaces = require("remotes.runtime-stage.recalculate-all-surfaces"),
    --
    getInterfaceVersion = require("remotes.runtime-stage.get-interface-version"),
    --
    getItemPrefix = require("remotes.runtime-stage.get-item-prefix"),
    --
    getTilePrefix = require("remotes.runtime-stage.get-tile-prefix"),
    --
})
