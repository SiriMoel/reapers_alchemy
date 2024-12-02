if not ModIsEnabled("souls") then
    function OnPlayerSpawned(player)
        GamePrint("Activate Souls.")
    end
    return
end

-- player
function OnPlayerSpawned(player)
    if GameHasFlagRun("reapers_alchemy_init") then return end

    local px, py = EntityGetTransform(player)

    GameAddFlagRun("reapers_alchemy_init")
end