dofile_once("mods/reapers_cauldron/files/scripts/utils.lua")
dofile_once("mods/souls/files/scripts/souls.lua")

soul_types_cauldron_item_info = {
    {
        name = "Bat",
        desc = "",
    },
    {
        name = "Fly",
        desc = "",
    },
    {
        name = "Worm",
        desc = "",
    },
    {
        name = "Spider",
        desc = "",
    },
    {
        name = "Zombie",
        desc = "",
    },
    {
        name = "Hiisi",
        desc = "",
    },
    {
        name = "Slime",
        desc = "",
    },
    {
        name = "Friend",
        desc = "",
    },
    {
        name = "Gold",
        desc = "",
    },
    {
        name = "Mage",
        desc = "",
    },
    {
        name = "Ghost",
        desc = "",
    },
    {
        name = "Fungi",
        desc = "",
    },
    {
        name = "Boss",
        desc = "",
    },
}

function CreateCauldronItem(x, y, soul1, soul2, soul3)
    local item = EntityLoad("mods/reapers_cauldron/files/cauldron/bases/item.xml", x, y)
    local soul1_id = SoulToCauldronId(soul1)
    local soul2_id = SoulToCauldronId(soul2)
    local soul3_id = SoulToCauldronId(soul3)
    EntityAddComponent2(item, "VariableStorageComponent", {
        _tags="souls_cauldron_soul_1",
        name="souls_cauldron_soul_1",
        value_string=soul1,
    })
    EntityAddComponent2(item, "VariableStorageComponent", {
        _tags="souls_cauldron_soul_2",
        name="souls_cauldron_soul_2",
        value_string=soul2,
    })
    EntityAddComponent2(item, "VariableStorageComponent", {
        _tags="souls_cauldron_item_3",
        name="souls_cauldron_item_3",
        value_string=soul3,
    })
    local name = "Talisman of " .. string.scramble(string.lower(soul_types_cauldron_item_info[soul1_id].name .. soul_types_cauldron_item_info[soul2_id].name .. soul_types_cauldron_item_info[soul3_id].name))
    local desc = "Function unknown. Maybe hold it or kick it... or both?"
    EntityAddComponent2(item, "UIInfoComponent", { name=name, })
    EntityAddComponent2(item, "ItemComponent", {
        _tags="enabled_in_world",
        max_child_items=0,
        is_pickable=true,
        is_equipable_forced=true,
        ui_sprite="mods/reapers_cauldron/files/cauldron/sprites/item/generated/" .. soul1_id .. "_" .. soul2_id .. "_" .. soul3_id .. ".png",
        preferred_inventory="QUICK",
        item_name=name,
        ui_description=desc,
    })
    local comp_ability = EntityAddComponent2(item, "AbilityComponent", {
        ui_name=name,
        throw_as_item=true,
    })
    ComponentObjectSetValue2(comp_ability, "gun_config", "deck_capacity", 0)
    local comp_pis = EntityGetFirstComponentIncludingDisabled(item, "PhysicsImageShapeComponent") or 0
    ComponentSetValue2(comp_pis, "image_file", "mods/reapers_cauldron/files/cauldron/sprites/item/generated/" .. soul1_id .. "_" .. soul2_id .. "_" .. soul3_id .. "_inworld.png")
    --[[EntityAddComponent2(item, "PhysicsImageShapeComponent", {
        body_id=1,
        centered=true,
        image_file=,
        material=CellFactory_GetType("rock_box2d_hard"),
    })]]
    EntityAddComponent2(item, "SpriteComponent", {
        _tags="enabled_in_hand",
        _enabled=false,
		offset_x=4,
		offset_y=4,
        image_file="mods/reapers_cauldron/files/cauldron/sprites/item/generated/" .. soul1_id .. "_" .. soul2_id .. "_" .. soul3_id .. "_inworld.png",
    })
    if AnyOfTableEquals({soul1, soul2, soul3}, "bat") then
        EntityAddComponent2(item, "GameEffectComponent", {
            _tags="enabled_in_hand",
            effect="PROTECTION_MELEE",
            frames=-1,
        })
    end
    if AnyOfTableEquals({soul1, soul2, soul3}, "fly") then
        EntityAddComponent2(item, "LuaComponent", {
            _tags="enabled_in_hand",
            script_source_file="mods/reapers_cauldron/files/cauldron/item_passive_fly.lua",
            execute_every_n_frame="10",
        })
    end
    if AnyOfTableEquals({soul1, soul2, soul3}, "worm") then
        EntityAddComponent2(item, "LuaComponent", {
            _tags="enabled_in_hand",
            script_source_file = "data/scripts/perks/radar_wand.lua",
            execute_every_n_frame = 1,
        })
    end
    if AnyOfTableEquals({soul1, soul2, soul3}, "spider") then

    end
    if AnyOfTableEquals({soul1, soul2, soul3}, "zombie") then
        EntityAddComponent2(item, "LuaComponent", {
            _tags="enabled_in_hand",
            script_source_file = "data/scripts/perks/radar_item.lua",
            execute_every_n_frame = 1,
        })
    end
    if AnyOfTableEquals({soul1, soul2, soul3}, "orcs") then
        EntityAddComponent2(item, "LuaComponent", {
            _tags="enabled_in_hand",
            script_source_file = "data/scripts/perks/radar.lua",
            execute_every_n_frame = 1,
        })
        EntityAddComponent2(item, "VariableStorageComponent", {
            _tags="souls_cauldron_item_projectile",
            name="souls_cauldron_item_projectile",
            value_string="mods/reapers_cauldron/files/cauldron/item_proj_orcs.xml",
        })
    end
    if AnyOfTableEquals({soul1, soul2, soul3}, "slimes") then
        EntityAddComponent2(item, "GameEffectComponent", {
            _tags="enabled_in_hand",
            effect="PROTECTION_RADIOACTIVITY",
            frames=-1,
        })
    end
    --[[if AnyOfTableEquals({soul1, soul2, soul3}, "friendly") then

    end]]
    --[[if AnyOfTableEquals({soul1, soul2, soul3}, "gilded") then

    end]]
    if AnyOfTableEquals({soul1, soul2, soul3}, "mage") then
        EntityAddComponent2(item, "GameEffectComponent", {
            _tags="enabled_in_hand",
            effect="PROTECTION_FIRE",
            frames=-1,
        })
    end
    if AnyOfTableEquals({soul1, soul2, soul3}, "ghost") then
        EntityAddTag(item, "evil_eye")
    end
    --[[if AnyOfTableEquals({soul1, soul2, soul3}, "fungus") then

    end]]
    if AnyOfTableEquals({soul1, soul2, soul3}, "boss") then
        EntityAddTag(item, "souls_cauldron_free_abilities")
    end
    return item
end

function CreateCauldronWand(x, y, wand, soul1, soul2, soul3)

end