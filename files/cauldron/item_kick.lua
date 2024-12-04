dofile_once("mods/reapers_cauldron/files/scripts/utils.lua")
dofile_once("mods/souls/files/scripts/souls.lua")

function kick(entity_who_kicked)
    local this = GetUpdatedEntityID()
    local root = EntityGetRootEntity(this)
    local player = GetPlayer()
    local x, y = EntityGetTransform(this)

    local soul1, soul2, soul3 = GetCauldronItemSouls(this)
    
    if this == root then -- item is on the floor
        GamePrint("kick")
    elseif root == player then -- item is being held by the player
        GamePrint("player kick")
        --[[local comps_proj = EntityGetComponentIncludingDisabled(this, "VariableStorageComponent", "souls_cauldron_item_projectile") or {}
        local comp_controls = EntityGetFirstComponentIncludingDisabled(player, "ControlsComponent") or 0
        local aim_x, aim_y = ComponentGetValue2(comp_controls, "mAimingVectorNormalized")
        local vel = 6000 -- TESTING
        local vel_x, vel_y = aim_x * vel, aim_y * vel
        for i=1,#comps_proj do
            local proj_path = ComponentGetValue2(comps_proj[i], "value_string")
            local proj = shoot_projectile(player, proj_path, x, y, vel_x, vel_y)
            local amount = 0
            amount = AmountOfTableEquals({soul1, soul2, soul3}, "bat")
            for i=1,amount do
                
            end
            amount = AmountOfTableEquals({soul1, soul2, soul3}, "fly")
            for i=1,amount do
                
            end
            amount = AmountOfTableEquals({soul1, soul2, soul3}, "spider")
            for i=1,amount do
                
            end
            amount = AmountOfTableEquals({soul1, soul2, soul3}, "zombie")
            for i=1,amount do
                
            end
            amount = AmountOfTableEquals({soul1, soul2, soul3}, "boss")
            for i=1,amount do
                
            end
        end]]
    end
end