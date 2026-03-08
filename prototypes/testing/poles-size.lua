local base_pole = data.raw["electric-pole"]["medium-electric-pole"]

local base_item = data.raw["item"]["medium-electric-pole"]

for i = 01, 03 do
    ---
    local new_pole = table.deepcopy(base_pole)

    new_pole.name = base_pole.name .. "-" .. i

    new_pole.minable.result = nil

    new_pole.collision_box = {
        {
            base_pole.collision_box[1][1] - i,
            base_pole.collision_box[1][2] - i,
        },
        {
            base_pole.collision_box[2][1] + i,
            base_pole.collision_box[2][2] + i,
        },
    }

    local new_item = table.deepcopy(base_item)

    new_item.place_result = new_pole.name

    new_item.name = new_pole.name

    data:extend({ new_pole, new_item }) -- add prototypes
    --
    --
end
