# Electric Tiles

A new and optimized version of _Powered Floor Extended!_

Adds conductive floor tiles that transmit power to adjacent tiles (including diagonals) and any structure on top of them, just place a power source or electric pole on top and enjoy the extra space!

> **Note:** Placing a large number of tiles (+5K) quickly may cause brief UPS spikes while the grid recalculates.

---

### How It Works

Electric Tiles form an **invisible power grid** beneath your base. Tiles connect to each other (including diagonals), and any entity placed on top -- machines, poles, roboports, accumulators -- is powered automatically, no wiring needed.

Grids recalculate dynamically whenever tiles are placed or removed. Processing is distributed across game ticks and handled per chunk, so the impact on performance is kept minimal even in large bases.

### Features

- **Blueprint compatible** -- Works seamlessly with blueprints and blueprint books.
- **Works in new and existing saves** -- No need to start a fresh game.
- **Hazard tile variants** -- Electric versions of hazard concretes are included out of the box.
- **Upgrade recipes** -- Tiles can be upgraded to the next tiers just like their base variants.

### Compatibilities

- **Dectorio**
- **Space Exploration**
- **Krastorio2**
- **Krastorio2 Spaced Out**

### Known Issues

- Mods that rewire electric poles may conflict with the invisible electric grids.

### Console Commands

You may want to use some of this commands, so u can fix/update the surfaces **_(planets)_**.

- **_F077ET-recalculateAllSurfaces_** -- Recalculates all the game surfaces.
- **_F077ET-recalculateLookingSurface_** -- Recalculates **ONLY** the surface that **YOU** are looking at.

---

# Modding Support

Electric Tiles exposes a **Data Stage interface** that allows other mods to create electric variants of any tile -- including tiles from third-party mods. This is the recommended way to extend Electric Tiles without modifying its source.

## Requirements

Before using the interface, make sure your mod meets the following:

1. Declare an optional dependency on Electric Tiles in your `info.json`:

```json
"dependencies": ["? electric-tiles >= 1.3.0"]
```

2. Use the interface exclusively during Factorio's **data stage** (i.e., inside `data.lua` or files required from it).

## How It Works

During the data stage, Electric Tiles registers a global table called **ElectricTilesDataInterface**. This table exposes the following methods:

- **modTilePrototypes(data)** -- Creates electric variants from tile/item/recipe prototypes.
- **getItemPrefix()** -- Returns the prefix applied to all generated item names.
- **getTilePrefix()** -- Returns the prefix applied to all generated tile names.
- **getInterfaceVersion()** -- Returns the current interface version string.

The core method is **modTilePrototypes()**. It accepts an array of entries, where each entry describes a tile variant to create. Electric Tiles will process each entry, apply defaults and overrides, and register the resulting prototypes automatically.

## modTilePrototypes() Reference

Each entry passed to **modTilePrototypes()** follows this structure:

```lua
ElectricTilesDataInterface.modTilePrototypes({
    {
        tile   = {}, -- [REQUIRED] TilePrototype data
        item   = {}, -- [OPTIONAL] ItemPrototype data
        recipe = {}, -- [OPTIONAL] RecipePrototype data
        others = {}, -- [OPTIONAL] Adapter configuration flags
    },
    -- additional entries...
})
```

You can pass multiple entries in a single call.

### tile -- TilePrototype

The tile data for the electric variant. This should mirror a standard [TilePrototype](https://lua-api.factorio.com/latest/prototypes/TilePrototype.html) definition.

**Assumed defaults** -- you can omit these and Electric Tiles will fill them in:

- **type** -- defaults to "tile"
- **order** -- defaults to "a[base]"
- **minable** -- defaults to the basic _MinableStructure_
- **localised_name** -- read from your locale files

**Overwritten properties** -- Electric Tiles will always set these, regardless of what you pass:

- **minable.result** -- set to the generated item, if item data was provided
- **placeable_by** -- set to the generated item, if item data was provided

**Modified properties** -- Electric Tiles adjusts these while preserving your input as a base:

- **name** -- a prefix is prepended (see getTilePrefix())
- **order** -- a postfix is appended
- **localised_name** -- a postfix is appended

### item -- ItemPrototype

The item used to place the electric tile. Mirrors a standard [ItemPrototype](https://lua-api.factorio.com/latest/prototypes/ItemPrototype.html).

**Assumed defaults:**

- **type** -- defaults to "item"
- **order** -- defaults to "a[base]"
- **subgroup** -- defaults to "F077ET-terrain"
- **place_as_tile** -- defaults to the basic _PlaceAsTileStructure_
- **localised_name** -- read from your locale files

**Overwritten properties:**

- **place_as_tile.result** -- set to the generated tile

**Modified properties:**

- **name** -- a prefix is prepended (see getItemPrefix())
- **icon(s)** -- a copper wire overlay icon is composited on top
- **order** -- a postfix is appended
- **localised_name** -- a postfix is appended

### recipe -- RecipePrototype

The crafting recipe for the electric tile. Mirrors a standard [RecipePrototype](https://lua-api.factorio.com/latest/prototypes/RecipePrototype.html).

**Assumed defaults:**

- **type** -- defaults to "recipe"
- **enabled** -- defaults to false
- **auto_recycle** -- defaults to true
- **category** -- defaults to "advanced-crafting"
- **ingredients** -- defaults to {1x iron stick, 1x copper cable, 1x base tile}

**Overwritten properties:**

- **name** -- always set to the internally generated name with prefix
- **results** -- always set to the generated item

No other properties are modified.

### others -- Adapter flags

Optional configuration that changes how the adapter processes an entry.

- **add_copper_wire_icon** _(boolean, default: true)_ -- set to false to skip the copper wire icon overlay on the item.
- **result_amount** _(integer, default: 1)_ -- number of tiles produced per craft.
- **use_default_recipe** _(boolean, default: false)_ -- if true and no recipe data was passed, the default recipe will be generated automatically.
- **technologies** _(array, default: {ElectricTilesTech})_ -- An array of technology name strings. If a recipe is created and is not enabled, the recipe will be added as an unlock effect for each listed technology.

## Example

The following example creates an electric variant of the **Space Platform tile** from the mod [_Space Platform, for ground_](https://mods.factorio.com/mod/space-platform-for-ground) by Snouz. Since that mod has already registered its prototypes, we can reference them directly:

```lua
-- data.lua (runs after the dependency mod's data stage)

ElectricTilesDataInterface.modTilePrototypes({
    {
        tile   = data.raw.tile["space-platform-for-ground"],
        item   = data.raw.item["space-platform-for-ground"],
        recipe = data.raw.recipe["space-platform-for-ground"],
        others = { add_copper_wire_icon = false, technologies = { "rocket-silo" } },
    }
})
```

Note that the copper wire icon is disabled here because the space platform tile already has a distinctive appearance.

---

## Additional Notes

- **You do not need pre-registered prototypes.** You can define tile, item, and recipe tables from scratch and pass them directly to **modTilePrototypes()**. The interface will handle prototype registration.
- **Passing only a tile is valid.** Item and recipe data are optional. If omitted, the electric tile will exist in the game but will have no craftable item or recipe associated with it -- useful for programmatic placement or editor use.
- **Load order matters.** Make sure Electric Tiles loads before your mod reads **ElectricTilesDataInterface**. The optional dependency declaration handles this automatically.
