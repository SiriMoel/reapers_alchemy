dofile_once("mods/reapers_cauldron/files/scripts/utils.lua")

soul_types_cauldron = {
    { soul = "bat", cost = 10, },
    { soul = "fly", cost = 5, },
    { soul = "worm", cost = 5, },
    { soul = "spider", cost = 3, },
    { soul = "zombie", cost = 5, },
    { soul = "orcs", cost = 10, },
    { soul = "slimes", cost = 10, },
    { soul = "friendly", cost = -3, },
    { soul = "gilded", cost = 30, },
    { soul = "mage", cost = 10, },
    { soul = "ghost", cost = 5, },
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

function GetSoulIdolSoul(entity)
    local soul
    local comp = EntityGetFirstComponentIncludingDisabled(entity, "VariableStorageComponent", "souls_idol_soul")
    if comp ~= nil then
        soul = ComponentGetValue2(comp, "value_string")
    end
    return soul
end

function GetRandomSoul2(x, y, frame)
    math.randomseed(x + frame, y + frame)
    local whichtype = "0"
    local whichtypes = {}
    for i=1,#soul_types do
        if GetSoulsCount(soul_types[i]) > 0 then
            table.insert(whichtypes, soul_types[i])
        end
    end
    if #whichtypes > 0 then
        whichtype = whichtypes[math.random(1, #whichtypes)]
    end
    return whichtype
end

function GetRandomSoulForWand2(wand, x, y, frame)
    math.randomseed(x + frame, y + frame)
    local which_soul = "0"
    local comp_whichsoul = EntityGetFirstComponentIncludingDisabled(wand, "VariableStorageComponent", "which_soul_type")
    if comp_whichsoul == nil then
        comp_whichsoul = EntityAddComponent2(wand, "VariableStorageComponent", {
            _tags="which_soul_type",
            name="which_soul_type",
            value_string="0",
        })
    end
    local comp_whichsoulnumber = EntityGetFirstComponentIncludingDisabled(wand, "VariableStorageComponent", "which_soul_type_number")
    if comp_whichsoulnumber == nil then
        comp_whichsoulnumber = EntityAddComponent2(wand, "VariableStorageComponent", {
            _tags="which_soul_type_number",
            name="which_soul_type_number",
            value_int="1",
        })
    end
    local comp_whichsoul = EntityGetFirstComponentIncludingDisabled(wand, "VariableStorageComponent", "which_soul_type") or 0
    local whichsoul = ComponentGetValue2(comp_whichsoul, "value_string")
    which_soul = whichsoul
    if which_soul == "0" then
        if GetSoulsCount("all") > 0 then
            which_soul = GetRandomSoul2(x, y, frame)
        else
            return "0"
        end
    end
    if GetSoulsCount(which_soul) > 0 then
        return which_soul
    else
        return "0"
    end
end