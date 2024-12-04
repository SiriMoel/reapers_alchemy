dofile_once("mods/reapers_cauldron/files/scripts/utils.lua")
dofile_once("mods/souls/files/scripts/souls.lua")

local spawn_phylactery_old = spawn_phylactery

function spawn_phylactery(x, y)
    LoadPixelScene("mods/reapers_cauldron/files/cauldron/cauldron.png", "mods/reapers_cauldron/files/cauldron/cauldron_visual.png", x-21, y-50, "")
    EntityLoad("mods/reapers_cauldron/files/cauldron/cauldron.xml", x, y)
    CreateItemActionEntity("MOLDOS_SOUL_IDOLISER", x, y - 10)
    spawn_phylactery_old(x, y - 10)
    --CreateCauldronItem(x, y - 10, "orcs", "worm", "bat")
end

