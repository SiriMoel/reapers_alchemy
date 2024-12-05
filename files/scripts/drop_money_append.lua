dofile_once( "data/scripts/game_helpers.lua" )
dofile_once("mods/reapers_cauldron/files/scripts/utils.lua")
--dofile_once("mods/souls/files/scripts/souls.lua")

local do_money_drop_old = do_money_drop

function do_money_drop( amount_multiplier, trick_kill )
    local entity = GetUpdatedEntityID()
    local x, y = EntityGetTransform(entity)
    local player = GetPlayer()

    if EntityHasTag(HeldItem(player), "souls_gilded_item")  then
        amount_multiplier = amount_multiplier * 2
    end

    do_money_drop_old( amount_multiplier, trick_kill )
end