dofile_once("mods/reapers_cauldron/files/scripts/utils.lua")

soul_types_cauldron = {
    { soul = "bat", cost = 10, },
    { soul = "fly", cost = 5, },
    { soul = "worm", cost = 5, },
    { soul = "spider", cost = 3, },
    { soul = "zombie", cost = 5, },
    { soul = "orcs", cost = 5, },
    { soul = "slimes", cost = 5, },
    { soul = "friendly", cost = -3, },
    { soul = "gilded", cost = 30, },
    { soul = "mage", cost = 10, },
    { soul = "ghost", cost = 10, },
    { soul = "fungus", cost = -3, },
    { soul = "boss", cost = 30, },
}

function SoulToCauldronId(soul)
    local id
    for i=1,#soul_types_cauldron do
        if soul_types_cauldron[i].soul == soul then
            id = i
            break
        end
    end
    return id
end

function CauldronIdToSoul(id)
    local soul
    soul = soul_types_cauldron[id].soul
    return soul
end

function GetCauldronItemSoul(item, which)
    local comp = EntityGetFirstComponentIncludingDisabled(item, "VariableStorageComponent", "souls_cauldron_soul_" .. tostring(which))
    if comp ~= nil then
        return ComponentGetValue2(comp, "value_string")
    end
end

function GetCauldronItemSouls(item)
    local soul1 = GetCauldronItemSoul(item, 1)
    local soul2 = GetCauldronItemSoul(item, 2)
    local soul3 = GetCauldronItemSoul(item, 3)
    return soul1, soul2, soul3
end