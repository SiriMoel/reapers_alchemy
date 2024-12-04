dofile_once("mods/reapers_cauldron/files/scripts/cauldron_utils.lua")

local cauldron = GetUpdatedEntityID()
local x, y = EntityGetTransform(cauldron)

local targets = EntityGetInRadiusWithTag(x, y, 20, "souls_idol")

local comp_emitter = EntityGetFirstComponentIncludingDisabled(cauldron, "ParticleEmitterComponent", "souls_reapers_cauldron_light")

if comp_emitter ~= nil then
    ComponentSetValue2(comp_emitter, "count_min", 5 * #targets)
    ComponentSetValue2(comp_emitter, "count_max", 5 * #targets)
end

local comp1 = EntityGetFirstComponentIncludingDisabled(cauldron, "InteractableComponent", "souls_reapers_cauldron_interact")
local comp2 = EntityGetFirstComponentIncludingDisabled(cauldron, "InteractableComponent", "souls_reapers_cauldron_interact")

if comp1 ~= nil and comp2 ~= nil then
    if #targets == 3 then
        EntitySetComponentIsEnabled(cauldron, comp1, true)
        EntitySetComponentIsEnabled(cauldron, comp2, true)
    else
        EntitySetComponentIsEnabled(cauldron, comp1, false)
        EntitySetComponentIsEnabled(cauldron, comp2, false)
    end
end
