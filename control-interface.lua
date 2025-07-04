remote.add_interface("ElectricTilesControlInterface", {
    --
    recalculateAllSurfaces = require("remotes.runtime-stage.recalculate-all-surfaces"),
    --
    registerTilePrototype = require("remotes.runtime-stage.register-tile-prototype"),
    --
    getInterfaceVersion = require("remotes.runtime-stage.get-interface-version"),
    --
    getItemPrefix = require("remotes.runtime-stage.get-item-prefix"),
    --
    getTilePrefix = require("remotes.runtime-stage.get-tile-prefix"),
    --
})
