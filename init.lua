if not ModIsEnabled("souls") then
    function OnPlayerSpawned(player)
        GamePrint("Activate Souls.")
    end
    return
end

dofile_once("mods/reapers_cauldron/files/scripts/utils.lua")

ModLuaFileAppend("mods/souls/files/scripts/souls.lua", "mods/reapers_cauldron/files/scripts/souls_append.lua")
dofile_once("mods/souls/files/scripts/souls.lua")

local nxml = dofile_once("mods/reapers_cauldron/lib/nxml.lua")

-- set & append
ModLuaFileAppend( "data/scripts/gun/gun_actions.lua", "mods/reapers_cauldron/files/actions.lua" )
ModLuaFileAppend( "data/scripts/items/drop_money.lua", "mods/reapers_cauldron/files/scripts/drop_money_append.lua" )

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
local content = ""
for i=1,#soul_types_cauldron do
    for ii=1,#soul_types_cauldron do
        for iii=1,#soul_types_cauldron do
            local image = ModImageMakeEditable("mods/reapers_cauldron/files/cauldron/sprites/wand/generated/" .. tostring(i) .. "_" .. tostring(ii) .. "_" .. tostring(iii) .. ".png", 25, 11)
            local image_i = ModImageMakeEditable("mods/reapers_cauldron/files/cauldron/sprites/wand/" .. tostring(i) .. ".png", 25, 11)
            local image_ii = ModImageMakeEditable("mods/reapers_cauldron/files/cauldron/sprites/wand/" .. tostring(ii) .. ".png", 25, 11)
            local image_iii = ModImageMakeEditable("mods/reapers_cauldron/files/cauldron/sprites/wand/" .. tostring(iii) .. ".png", 25, 11)
            for x=1,9 do
                for y=1,11 do
                    ModImageSetPixel(image, x, y, ModImageGetPixel(image_i, x, y))
                end
            end
            for x=10,17 do
                for y=1,11 do
                    ModImageSetPixel(image, x, y, ModImageGetPixel(image_ii, x, y))
                end
            end
            for x=18,25 do
                for y=1,11 do
                    ModImageSetPixel(image, x, y, ModImageGetPixel(image_iii, x, y))
                end
            end
            local file = ModTextFileGetContent("mods/reapers_cauldron/files/cauldron/sprites/wand/generated/" .. tostring(i) .. "_" .. tostring(ii) .. "_" .. tostring(iii) .. ".xml")
            local content = "<Sprite filename=\"mods/reapers_cauldron/files/cauldron/sprites/wand/generated/"  .. tostring(i) .. "_" .. tostring(ii) .. "_" .. tostring(iii) .. ".png\" > <RectAnimation name=\"default\" pos_x=\"1\" pos_y=\"1\" offset_x=\"3\" offset_y=\"4\" frame_width=\"23\" frame_height=\"9\" has_offset=\"1\" frame_count=\"1\" frame_wait=\"0.2\" frames_per_row=\"10\" loop=\"0\"  > </RectAnimation> </Sprite>"
            ModTextFileSetContent("mods/reapers_cauldron/files/cauldron/sprites/wand/generated/" .. tostring(i) .. "_" .. tostring(ii) .. "_" .. tostring(iii) .. ".xml", tostring(content))
        end
    end
end

-- player
function OnPlayerSpawned(player)
    if GameHasFlagRun("reapers_cauldron_init") then return end
    print(file)

    local px, py = EntityGetTransform(player)

    --dofile_once("mods/reapers_cauldron/files/scripts/cauldron_utils.lua")
    --CreateCauldronItem(px, py - 20, "orcs", "worm", "bat")
    --for i=1,100 do AddSouls(soul_types[math.random(1,#soul_types)], 10) end

    GameAddFlagRun("reapers_cauldron_init")
end