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
    --[[if AnyOfTableEquals({soul1, soul2, soul3}, "spider") then

    end]]
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
        EntityAddComponent2(item, "VariableStorageComponent", {
            _tags="souls_cauldron_item_projectile",
            name="souls_cauldron_item_projectile",
            value_string="mods/reapers_cauldron/files/cauldron/item_proj_slimes.xml",
        })
    end
    --[[if AnyOfTableEquals({soul1, soul2, soul3}, "friendly") then

    end]]
    if AnyOfTableEquals({soul1, soul2, soul3}, "gilded") then
        EntityAddTag(item, "souls_gilded_item")
    end
    if AnyOfTableEquals({soul1, soul2, soul3}, "mage") then
        EntityAddComponent2(item, "GameEffectComponent", {
            _tags="enabled_in_hand",
            effect="PROTECTION_FIRE",
            frames=-1,
        })
        EntityAddComponent2(item, "VariableStorageComponent", {
            _tags="souls_cauldron_item_projectile",
            name="souls_cauldron_item_projectile",
            value_string="mods/reapers_cauldron/files/cauldron/item_proj_mage.xml",
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
    local comp_ability = EntityGetFirstComponentIncludingDisabled(wand, "AbilityComponent")
    if comp_ability == nil then return print("SOULS - could not find AbilityComponent for CreateCauldronWand()") end
    local amount_bat = AmountOfTableEquals({soul1, soul2, soul3}, "bat")
    local amount_fly = AmountOfTableEquals({soul1, soul2, soul3}, "fly")
    local amount_worm = AmountOfTableEquals({soul1, soul2, soul3}, "worm")
    local amount_spider = AmountOfTableEquals({soul1, soul2, soul3}, "spider")
    local amount_zombie = AmountOfTableEquals({soul1, soul2, soul3}, "zombie")
    local amount_orcs = AmountOfTableEquals({soul1, soul2, soul3}, "orcs")
    local amount_slimes = AmountOfTableEquals({soul1, soul2, soul3}, "slimes")
    local amount_friendly = AmountOfTableEquals({soul1, soul2, soul3}, "friendly")
    local amount_gilded = AmountOfTableEquals({soul1, soul2, soul3}, "gilded")
    local amount_mage = AmountOfTableEquals({soul1, soul2, soul3}, "mage")
    local amount_ghost = AmountOfTableEquals({soul1, soul2, soul3}, "ghost")
    local amount_fungus = AmountOfTableEquals({soul1, soul2, soul3}, "fungus")
    local amount_boss = AmountOfTableEquals({soul1, soul2, soul3}, "boss")
    local rt = tonumber(ComponentObjectGetValue(comp_ability, "gun_config", "reload_time")) or 0 -- reload time
    local frw = tonumber(ComponentObjectGetValue(comp_ability, "gunaction_config", "fire_rate_wait")) or 0 -- fire rate wait
    local mcs = tonumber(ComponentGetValue2(comp_ability, "mana_charge_speed")) or 0 -- mana charge speed
    local mm = tonumber(ComponentGetValue2(comp_ability, "mana_max")) or 0 -- mana max
    local cap = tonumber(ComponentObjectGetValue( comp_ability, "gun_config", "deck_capacity")) or 0 -- deck capacity 
    rt = math.ceil(math.max(rt - (2 * (amount_bat + amount_fly)) + (amount_mage + amount_ghost + amount_fungus + amount_zombie), 0))
    frw = math.ceil(math.max(frw - (amount_bat + amount_fly) + (amount_mage + amount_ghost + amount_fungus + amount_zombie), 0))
    mcs = math.ceil(math.min(mcs + (35 * (amount_mage + amount_ghost)) - ( 10 * (amount_bat + amount_fly + amount_fungus + amount_zombie)), 10000))
    mm = math.ceil(math.min(mm + (50 * (amount_mage + amount_ghost)) - ( 20 * (amount_bat + amount_fly + amount_fungus + amount_zombie)), 10000))
    cap = math.ceil(math.min(cap + (amount_fungus) + (amount_zombie), 26))
    ComponentObjectSetValue2(comp_ability, "gun_config", "reload_time", rt)
    ComponentObjectSetValue2(comp_ability, "gunaction_config", "fire_rate_wait", frw)
    ComponentSetValue2(comp_ability, "mana_charge_speed", mcs)
    ComponentSetValue2(comp_ability, "mana_max", mm)
    ComponentObjectSetValue2(comp_ability, "gun_config", "deck_capacity", cap)
    EntitySetTransform(wand, x, y)
    return wand
end