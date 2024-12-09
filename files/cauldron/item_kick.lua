dofile_once("mods/reapers_cauldron/files/scripts/utils.lua")
dofile_once("mods/souls/files/scripts/souls.lua")

function kick(entity_who_kicked)
    local this = GetUpdatedEntityID()
    local root = EntityGetRootEntity(this)
    local player = GetPlayer()
    local x, y = EntityGetTransform(this)
    local frame = GameGetFrameNum()
    math.randomseed(x + frame, y + frame)
    local free = false
    local soul1, soul2, soul3 = GetCauldronItemSouls(this)
    if AnyOfTableEquals({soul1, soul2, soul3}, "boss") or EntityHasTag(this, "souls_cauldron_free_abilities") then
        free = true
    end
    if this == root then -- item is on the floor
        --GamePrint("kick") -- TESTING
        if AnyOfTableEquals({soul1, soul2, soul3}, "worm") then
            local worms = {"worm_tiny", "worm", "worm_big"}
            local which = worms[math.random(1, #worms)]
            EntityLoad("data/entities/animals/" .. which .. ".xml", x, y)
            EntityKill(this)
        end
        local amount_spider = AmountOfTableEquals({soul1, soul2, soul3}, "spider")
        if amount_spider > 0 then
            if (GetSoulsCount("all") - GetSoulsCount("boss")) >= amount_spider then
                for i=1,amount_spider do
                    EntityLoad("data/entities/animals/longleg.xml", x, y)
                    if not free then RemoveSoul(GetRandomSoul(false)) end
                end
            else
                GamePrint("You do not have enough souls for this.")
            end
        end
        local amount_gilded = AmountOfTableEquals({soul1, soul2, soul3}, "gilded")
        if amount_gilded > 0 then
            if (GetSoulsCount("all") - GetSoulsCount("boss")) >= amount_gilded then
                for i=1,amount_gilded do
                    local outcome = math.random(1, 20)
                    if outcome == 20 then
                        shoot_projectile( this, "data/entities/items/pickup/goldnugget_200.xml", x, y, math.random(-40,40), math.random(-40,40))
                    elseif outcome == 15 then
                        shoot_projectile( this, "data/entities/items/pickup/goldnugget_50.xml", x, y, math.random(-40,40), math.random(-40,40))
                        shoot_projectile( this, "data/entities/items/pickup/goldnugget_50.xml", x, y, math.random(-40,40), math.random(-40,40))
                    elseif outcome < 10 then
                        shoot_projectile( this, "data/entities/items/pickup/goldnugget_10.xml", x, y, math.random(-40,40), math.random(-40,40))
                        shoot_projectile( this, "data/entities/items/pickup/goldnugget_10.xml", x, y, math.random(-40,40), math.random(-40,40))
                    else
                        shoot_projectile( this, "data/entities/items/pickup/goldnugget_10.xml", x, y, math.random(-40,40), math.random(-40,40))
                        shoot_projectile( this, "data/entities/items/pickup/goldnugget_10.xml", x, y, math.random(-40,40), math.random(-40,40))
                        shoot_projectile( this, "data/entities/items/pickup/goldnugget_10.xml", x, y, math.random(-40,40), math.random(-40,40))
                    end
                    if not free then RemoveSoul(GetRandomSoul(false)) end
                end
            else
                GamePrint("You do not have enough souls for this.")
            end
        end
        if AnyOfTableEquals({soul1, soul2, soul3}, "mage") then
            local materials = {
                { probability = 0.9, id = "magic_liquid_movement_faster", },
                { probability = 0.2, id = "magic_liquid_protection_all", },
                { probability = 0.7, id = "magic_liquid_berserk", },
                { probability = 0.8, id = "magic_liquid_mana_regeneration", },
                { probability = 0.2, id = "material_confusion", },
                { probability = 0.9, id = "magic_liquid_faster_levitation", },
                { probability = 0.6, id = "magic_liquid_polymorph", },
                { probability = 0.6, id = "magic_liquid_teleportation", },
                { probability = 0.7, id = "magic_liquid_worm_attractor", },
                { probability = 0.6, id = "magic_liquid_invisibilty", },
                { probability = 0.9, id = "magic_liquid_charm", },
                { probability = 0.01, id = "magic_liquid_hp_regeneration", },
                { probability = 0.01, id = "midas_precursor", },
            }
            local which = PickRandomFromTableWeighted(x + frame, y + frame, materials) or {}
            EntityConvertToMaterial(this, which.id, true, false)
            EntityKill(this) -- is this necessary?
        end
        if AnyOfTableEquals({soul1, soul2, soul3}, "friendly") then
            GamePlaySound("data/audio/Desktop/animals.bank", "animals/sheep", x, y) -- no idea how audio works
        end
    elseif this == HeldItem(player) then -- item is being held by the player
        --GamePrint("player kick") -- TESTING
        local comps_proj = EntityGetComponentIncludingDisabled(this, "VariableStorageComponent", "souls_cauldron_item_projectile") or {}
        local comp_controls = EntityGetFirstComponentIncludingDisabled(player, "ControlsComponent") or 0
        local aim_x, aim_y = ComponentGetValue2(comp_controls, "mAimingVectorNormalized")
        local vel = 200
        local vel_x, vel_y = aim_x * vel, aim_y * vel
        for i=1,#comps_proj do
            local proj_path = ComponentGetValue2(comps_proj[i], "value_string")
            local proj = shoot_projectile(player, proj_path, x, y, vel_x, vel_y)
            local amount = 0
            amount = AmountOfTableEquals({soul1, soul2, soul3}, "bat") -- increase speed
            local comp_velocity = EntityGetFirstComponentIncludingDisabled(proj, "VelocityComponent")
            --GamePrint(tostring(amount))
            --GamePrint(tostring(comp_velocity))
            if comp_velocity ~= nil then
                local pvel_x,pvel_y = ComponentGetValueVector2( comp_velocity, "mVelocity")
                pvel_x = vel_x * (1 + (2.5 * amount))
                pvel_y = vel_y * (1 + (2.5 * amount))
                ComponentSetValueVector2( comp_velocity, "mVelocity", pvel_x, pvel_y)
            end
            amount = AmountOfTableEquals({soul1, soul2, soul3}, "fly") -- add homing
            if amount > 0 then
                EntityAddComponent2(proj, "HomingComponent", {
                    target_tag="homing_target",
                    homing_targeting_coeff=6,
                    detect_distance=50 * amount,
                    homing_velocity_multiplier=1.1,
                })
            end
            amount = AmountOfTableEquals({soul1, soul2, soul3}, "spider") -- add melee damage
            local comp_proj = EntityGetFirstComponentIncludingDisabled(proj, "ProjectileComponent")
            if comp_proj ~= nil then
                ComponentObjectSetValue2(comp_proj, "damage_by_type", "melee", ComponentObjectGetValue2(comp_proj, "damage_by_type", "melee") + (0.7 * amount))
            end
            amount = AmountOfTableEquals({soul1, soul2, soul3}, "zombie") -- add proj damage
            if comp_proj ~= nil then
                ComponentSetValue2(comp_proj, "damage", ComponentGetValue2(comp_proj, "damage") + (0.7 * amount))
            end
            amount = AmountOfTableEquals({soul1, soul2, soul3}, "boss") -- Reap souls
            if amount > 0 then
                EntityAddComponent2(proj, "LuaComponent", {
                    script_source_file="mods/souls/files/entities/projectiles/reaping_halo/reaping_halo.lua",
		            execute_every_n_frame="1",
                })
            end
        end
        local amount_gilded = AmountOfTableEquals({soul1, soul2, soul3}, "gilded")
        if amount_gilded > 0 then
            if (GetSoulsCount("all") - GetSoulsCount("boss")) >= math.max(amount_gilded + 1, 3) then
                local a = 16
                a = a * amount_gilded
                ConvertMaterialOnAreaInstantly(x, y, a, a, CellFactory_GetType("blood"), CellFactory_GetType("gold"), true, false)
                if free then return end
                for i=1,math.max(amount_gilded + 1, 3) do
                    RemoveSoul(GetRandomSoul(false))
                end
            else
                GamePrint("You do not have enough souls for this.")
            end
        end
        if AnyOfTableEquals({soul1, soul2, soul3}, "friendly") then
            GamePlaySound("data/audio/Desktop/animals.bank", "animals/sheep", x, y) -- no idea how audio works
        end
    end
end