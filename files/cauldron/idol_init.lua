dofile_once("mods/reapers_cauldron/files/scripts/utils.lua")
dofile_once("mods/souls/files/scripts/souls.lua")

local this = GetUpdatedEntityID()
local player = GetPlayer()
local wand = HeldItem(player)
local x, y = EntityGetTransform(this)
local iter = 0

local soul = GetRandomSoulForWand2(wand, x, y, GameGetFrameNum() + iter)

while soul == "mage_corrupted" or soul == "ghost_whisp" do
    iter = iter + 1
    soul = GetRandomSoulForWand2(wand, x, y, GameGetFrameNum() + iter)
end

if soul == nil or soul == 0 or soul == "0" then
	GamePrint("You do not have enough souls for this.")
    EntityKill(this)
else
    RemoveSoul(soul)
    ComponentSetValue2(EntityGetFirstComponentIncludingDisabled(this, "VariableStorageComponent", "souls_idol_soul") or 0, "value_string", soul)
    ComponentSetValue2(EntityGetFirstComponentIncludingDisabled(this, "PhysicsImageShapeComponent") or 0, "image_file", "mods/souls/files/entities/souls/sprites/soul_" .. soul .. ".png")
    ComponentSetValue2(EntityGetFirstComponentIncludingDisabled(this, "ItemComponent") or 0, "ui_sprite", "mods/souls/files/entities/souls/sprites/soul_" .. soul .. ".png")
    ComponentSetValue2(EntityGetFirstComponentIncludingDisabled(this, "SpriteComponent") or 0, "image_file", "mods/souls/files/entities/souls/sprites/soul_" .. soul .. ".png")
    EntityRefreshSprite(this, EntityGetFirstComponentIncludingDisabled(this, "SpriteComponent") or 0)
end
