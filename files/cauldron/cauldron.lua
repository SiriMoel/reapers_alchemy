dofile_once("mods/reapers_cauldron/files/scripts/cauldron_utils.lua")

local cauldron = GetUpdatedEntityID()
local x, y = EntityGetTransform(cauldron)

local targets = EntityGetInRadiusWithTag(x, y, 20, "souls_idol")
local targets2 = {}

if #targets < 1 then return end -- performance reasons?

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

local comp_emitter = EntityGetFirstComponentIncludingDisabled(cauldron, "ParticleEmitterComponent")

if comp_emitter ~= nil then
    ComponentSetValue2(comp_emitter, "count_min", 5 * #targets2)
    ComponentSetValue2(comp_emitter, "count_max", 5 * #targets2)
end

local comp1 = EntityGetFirstComponentIncludingDisabled(cauldron, "InteractableComponent", "souls_reapers_cauldron_interact")
local comp2 = EntityGetFirstComponentIncludingDisabled(cauldron, "LuaComponent", "souls_reapers_cauldron_interact")

if comp1 ~= nil then
    ComponentSetValue2(comp1, "ui_text", "[FORGE: " .. cost .. " SOULS]")
end

if comp1 ~= nil and comp2 ~= nil then
    if #targets2 == 3 then
        EntitySetComponentIsEnabled(cauldron, comp1, true)
        EntitySetComponentIsEnabled(cauldron, comp2, true)
    else
        EntitySetComponentIsEnabled(cauldron, comp1, false)
        EntitySetComponentIsEnabled(cauldron, comp2, false)
    end
end
