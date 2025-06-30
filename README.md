# Electric Tiles

A new and optimized version of _Powered Floor Extended_! Adds conductive floor tiles that transmit power to adjacent tiles (including diagonals) and any structure on top of them. Just place a power source or electric pole and enjoy the extra space!

**[BEWARE]**: Due to technical limitations, placing a huge number of tiles (+5K aprox) pretty fast WILL cause large UPS spikes for a few seconds.

### How It Works

Electric Tiles form an **invisible power grid** under your base:

- Tiles connect with each other (including diagonally), forming local power grids
- Any entity placed on top (machines, poles, roboports, etc.) is powered automatically
- Optimized to avoid placing entities per tile like older versions (better UPS!)
- Power propagation is calculated **per chunk** when tiles are built or removed

### Features

- Fully blueprint-compatible
- Works in both **new and existing saves**
- Recalculates grids dynamically on placement/removal
- Designed with performance in mind (no 1-entity-per-tile overhead)
- Multiple tiles can be **adapted** to have an electric versión _(modding support)_

### Known Issues / To-Do

- Nothing for now ...

### Feedback Welcome

This is my **first official mod**, so any suggestions, feedback, or improvement ideas are more than welcome. Feel free to reach out!

# Modding Support

With the release of the version **1.2.2**, Electric Tiles is now able to "adapt" other tiles and process them internally. If you are a modder, keep reading for learning how to create electric variants of many tiles. For prototyping references/properties/functions visit the **official Factorio API page**.

### Requeriments

1. Add an optional dependency for Electric Tiles >= 1.2.2
2. Correctly call the _Data Stage Interface_ for creating the tiles.
3. Correctly call the *Runtime Stage Interfac*e for registering the tiles.

## Stage 1: Data Stage (data.lua)

During Factorio's Data-Stage, this mod will create a global table: **ElectricTilesDataInterface**. This table will contain special methods:

- adaptTilePrototype(): Main method for creating electric tiles' variants.
- getItemPrefix(): Get item prefix added to the name of all tiles' items.
- getTilePrefix(): Get tile prefix added to the name of each tile variant.
- getInterfaceVersion(): Obtain the interface current version.

In order to start "adapting" a new tile variant, you need to pass to the function **adaptTilePrototype()** data with the following format:

```lua
ElectricTilesDataInterface.adaptTilePrototype({
    {
        tile       = {}, -- [REQUIRED] EXACTLY the same data required for creating a Tile Prototype
        item       = {}, -- [REQUIRED] EXACTLY the same data required for creating an Item Prototype
        recipe     = {}, -- [OPTIONAL] EXACTLY the same data required for creating Recipe Prototype
        others     = {}, -- [OPTIONAL] special values for the interface to consider while processing
        technology = {}, -- [OPTIONAL] array of tech names for unlocking the variant
    },
    ...,
    ...,
})
```

#### **# tile** _(table: TilePrototype)_

- In some cases, Electric Tiles **assumes** the following default values _(which means that you **don't necessarily need to pass them** in this parameter's table)_:

  - _type_ (default: "tile")
  - _order_ (default: "a[base]")
  - _minable_ (default: Basic _MinableStructure_)

- Electric Tiles will **overwrite** certain properties _(which means that you **don't have control** over these values)_:

  - _name_ (special name with prefix)
  - _minable.result_ (item returned on removal)
  - _localised_name_ (special in-game label name)

- Electric Tiles will **modify** certain properties _(which means that you **have partial control** over the final values)_:
  - _layer_ (+64 will be added)
  - _order_ (a postfix will be added)

#### **# item** _(table: ItemPrototype)_

- In some cases, Electric Tiles **assumes** the following default values:

  - _type_ (default: "item")
  - _order_ (default: "a[base]")
  - _place_as_tile_ (default: Basic _PlaceAsTileStructure_)

- Electric Tiles will **overwrite** certain properties:

  - _name_ (special name with prefix)
  - _place_as_tile.result_ (tile placed on built)
  - _localised_name_ (special in-game label name)

- Electric Tiles will **modify** certain properties:
  - _icon(s)_ (the copper-wire icon will be added)
  - _order_ (a postfix will be added)

#### **# recipe** _(table: RecipePrototype)_

- In some cases, Electric Tiles **assumes** the following default values:

  - _type_ (default: "recipe")
  - _enabled_ (default: false)
  - _category_ (default: "advanced-crafting")
  - _ingredients_ (default: { 1 x IronStick, 1 x CopperCable, 1 x Tile } )

- Electric Tiles will **overwrite** certain properties:

  - _name_ (special name with prefix)
  - _results_ (final crafting product)

- Electric Tiles will **NOT modify** any properties ...

#### **# others** _(table: Dictionary)_

- These are some special parameters that change how the adapter works:

  - _add_copper_wire_icon_ (boolean) (If **false**, the copper wire icon will NOT be added)

#### **# technology** _(table: StringArray)_

- These are the technologies that unlock this special electric variant.

## Stage 1: Example

In this code example we are creating an electric variant for the mod **"Space Platform, for ground"**, by Snouz.

```lua
-- Snouz already created and registered the tile data, so we take it and pass it to the interface.

ElectricTilesDataInterface.adaptTilePrototype({
    {
        item = data.raw.item["space-platform-for-ground"],
        --
        tile = data.raw.tile["space-platform-for-ground"],
        --
        recipe = data.raw.recipe["space-platform-for-ground"],
        --
        others = { add_copper_wire_icon = false },
        --
        technology = { "rocket-silo" }
    }
})
```

## Stage 2: Runtime Stage (control.lua)

During Factorio's Runtime-Stage, this mod will create a remote interface: **ElectricTilesControlInterface**. This remote will contain special methods:

- registerTilePrototype(): Main method for registering electric tiles' variants.
- getItemPrefix(): Get item prefix added to the name of all tiles' items.
- getTilePrefix(): Get tile prefix added to the name of each tile variant.
- getInterfaceVersion(): Obtain the interface current version.

In order to start "registering" an existing tile variant, you need to pass to the function **registerTilePrototype()** the BASE prototypes' names of the tiles that you created, **WHILE** inside of a handler for the events _on_init_ and _on_load_:

```lua
local names = { "space-platform-for-ground" }

remote.call("ElectricTilesControlInterface", "registerTilePrototype", names)
```

## Stage 2: Example

In this code example we correctly call the remote interface inside the main handler.

```lua
-- It is impossible to call a remote interface OUTSIDE of any event.

local function my_register(_data_)

    local names = { "space-platform-for-ground" }

    remote.call("ElectricTilesControlInterface", "registerTilePrototype", names)

end

script.on_init(my_register)

script.on_load(my_register)
```

## Final Result

If we followed these steps correctly, then we should have a result similar to this:

<div align="center">

![alt text](https://raw.githubusercontent.com/J0ss077/ElectricTilesFactorioMod/refs/heads/main/.github/images/image-001.png)
![alt text](https://raw.githubusercontent.com/J0ss077/ElectricTilesFactorioMod/refs/heads/main/.github/images/image-002.png)

![alt text](https://raw.githubusercontent.com/J0ss077/ElectricTilesFactorioMod/refs/heads/main/.github/images/image-003.png)

</div>

## Warnings!!

- If for some reason the data-stage process completes correctly, but the runtime-stage not, then the player will have electric tiles that don't work and **WILL NOT WORK EVEN** if in future releases of your mod the problem gets fixed ...

## Extra Notes

- You don't need to register a tile/item/recipe prototype to be able to create an electric variant. You can just pass the exactly same data to the DataInterface, then it will handle the creation of the variant.
- Remember to **ALWAYS** handle the remote calling inside the respective events.
- If you think that the modding documentation should be fixed/upgraded/re-done, I'm able to take suggestions.
