dofile_once("mods/reapers_cauldron/files/scripts/utils.lua")
dofile_once("mods/souls/files/scripts/souls.lua")
dofile_once("mods/reapers_cauldron/files/scripts/cauldron_utils.lua")

function interacting( entity_who_interacted, entity_interacted, interactable_name )
    local cauldron = GetUpdatedEntityID()
    local x, y = EntityGetTransform(cauldron)

    local targets = EntityGetInRadiusWithTag(x, y, 20, "souls_idol")
    local targets2 = {}

    for i=1,#targets do
        if EntityGetRootEntity(targets[i]) == targets[i] then
            table.insert(targets2, targets[i])
        end
    end

    local cost = 10

    local soul1_id = SoulToCauldronId(GetSoulIdolSoul(targets2[1]))
    local soul2_id = SoulToCauldronId(GetSoulIdolSoul(targets2[2]))
    local soul3_id = SoulToCauldronId(GetSoulIdolSoul(targets2[3]))

    cost = 10 + soul_types_cauldron[soul1_id].cost + soul_types_cauldron[soul2_id].cost + soul_types_cauldron[soul3_id].cost

    local wand
    local wands = EntityGetInRadiusWithTag(x, y, 20, "wand") or {}
    if #wands > 0 then
        for i=1,#wands do
            if EntityGetRootEntity(wands[i]) == wands[i] then
                wand = wands[i]
                break
            end
        end
    end

    if #targets2 == 3 then
        if (GetSoulsCount("all") - GetSoulsCount("boss")) >= cost then
            for i=1,cost do
                RemoveSoul(GetRandomSoul(false))
            end
            GamePrintImportant("THE CAULDRON HUMS...", "Forging complete!", "mods/reapers_cauldron/files/souls_decoration.png")
            if wand ~= nil then
                wand = CreateCauldronWand(x, y, wand, GetSoulIdolSoul(targets[1]), GetSoulIdolSoul(targets[2]), GetSoulIdolSoul(targets[3]))
                for i,v in ipairs(targets2) do
                    EntityKill(v)
                end
            else
                local item = CreateCauldronItem(x, y, GetSoulIdolSoul(targets[1]), GetSoulIdolSoul(targets[2]), GetSoulIdolSoul(targets[3]))
                for i,v in ipairs(targets2) do
                    EntityKill(v)
                end
            end
        else
            GamePrint("You do not have enough souls for this.")
        end
    else
        GamePrint("hey drop them idols ok")
    end
end