if not ModIsEnabled("souls") then
    function OnPlayerSpawned(player)
        GamePrint("Activate Souls.")
    end
    return
end

dofile_once("mods/reapers_cauldron/files/scripts/utils.lua")

ModLuaFileAppend("mods/souls/files/scripts/souls.lua", "mods/reapers_cauldron/files/scripts/souls_append.lua")
dofile_once("mods/souls/files/scripts/souls.lua")

-- set & append
ModLuaFileAppend( "data/scripts/gun/gun_actions.lua", "mods/reapers_cauldron/files/actions.lua" )

-- biome things
local biomes = {
    {
        path = "data/scripts/biomes/mountain_tree.lua",
        script = "mods/reapers_cauldron/files/scripts/biome/mountain_tree.lua",
    },
}
for i,v in ipairs(biomes) do
    if ModTextFileGetContent(v.path) ~= nil then
        ModLuaFileAppend(v.path, v.script)
    end
end

-- create icons
for i=1,#soul_types_cauldron do
    for ii=1,#soul_types_cauldron do
        for iii=1,#soul_types_cauldron do
            local image = ModImageMakeEditable("mods/reapers_cauldron/files/cauldron/sprites/item/generated/" .. tostring(i) .. "_" .. tostring(ii) .. "_" .. tostring(iii) .. ".png", 16, 16)
            local image_i = ModImageMakeEditable("mods/reapers_cauldron/files/cauldron/sprites/item/" .. tostring(i) .. ".png", 16, 16)
            local image_ii = ModImageMakeEditable("mods/reapers_cauldron/files/cauldron/sprites/item/" .. tostring(ii) .. ".png", 16, 16)
            local image_iii = ModImageMakeEditable("mods/reapers_cauldron/files/cauldron/sprites/item/" .. tostring(iii) .. ".png", 16, 16)
            for x=1,6 do
                for y=1,16 do
                    ModImageSetPixel(image, x, y, ModImageGetPixel(image_i, x, y))
                end
            end
            for x=7,11 do
                for y=1,16 do
                    ModImageSetPixel(image, x, y, ModImageGetPixel(image_ii, x, y))
                end
            end
            for x=12,16 do
                for y=1,16 do
                    ModImageSetPixel(image, x, y, ModImageGetPixel(image_iii, x, y))
                end
            end
            local image_inworld = ModImageMakeEditable("mods/reapers_cauldron/files/cauldron/sprites/item/generated/" .. tostring(i) .. "_" .. tostring(ii) .. "_" .. tostring(iii) .. "_inworld" .. ".png", 8, 8)
            local image_inworld_i = ModImageMakeEditable("mods/reapers_cauldron/files/cauldron/sprites/item/" .. tostring(i) .. "_inworld.png", 8, 8)
            local image_inworld_ii = ModImageMakeEditable("mods/reapers_cauldron/files/cauldron/sprites/item/" .. tostring(ii) .. "_inworld.png", 8, 8)
            local image_inworld_iii = ModImageMakeEditable("mods/reapers_cauldron/files/cauldron/sprites/item/" .. tostring(iii) .. "_inworld.png", 8, 8)
            for x=1,3 do
                for y=1,8 do
                    ModImageSetPixel(image_inworld, x, y, ModImageGetPixel(image_inworld_i, x, y))
                end
            end
            for x=4,5 do
                for y=1,8 do
                    ModImageSetPixel(image_inworld, x, y, ModImageGetPixel(image_inworld_ii, x, y))
                end
            end
            for x=6,8 do
                for y=1,8 do
                    ModImageSetPixel(image_inworld, x, y, ModImageGetPixel(image_inworld_iii, x, y))
                end
            end
        end
    end
end

-- player
function OnPlayerSpawned(player)
    if GameHasFlagRun("reapers_cauldron_init") then return end

    local px, py = EntityGetTransform(player)

    --dofile_once("mods/reapers_cauldron/files/scripts/cauldron_utils.lua")
    --CreateCauldronItem(px, py - 20, "orcs", "worm", "bat")

    GameAddFlagRun("reapers_cauldron_init")
end