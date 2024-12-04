dofile_once("mods/reapers_cauldron/files/scripts/utils.lua")
dofile_once("mods/souls/files/scripts/souls.lua")

actions_to_insert = {
	{
		id          = "SOUL_IDOLISER",
		name 		= "Soul Idoliser",
		description = "Cast to turn a soul into an idol.",
		sprite 		= "mods/reapers_cauldron/files/spell_icons/soul_idoliser.png",
		related_extra_entities = { "mods/souls/files/entities/projectiles/reap_from_fire/reaping_shot.xml" },
		type 		= ACTION_TYPE_UTILITY,
		spawn_level                       = "",
		spawn_probability                 = "",
		spawn_level_table = {},
		spawn_probability_table = {},
		price = 100,
		mana = 30,
		action 		= function()
            if reflecting then return end
            local entity = GetUpdatedEntityID()
            local x, y = EntityGetTransform(entity)
            EntityLoad("mods/reapers_cauldron/files/cauldron/idol.xml", x, y)
		end,
	},
}

for i,action in ipairs(actions_to_insert) do
	action.id = "MOLDOS_" .. action.id
	local levels = ""
	local probabilities = ""
	levels = ""
	probabilities = ""
	local multiplier = tonumber(ModSettingGet("souls.spell_spawn_chance_multiplier"))
	for i,level in ipairs(action.spawn_level_table) do
		levels = levels .. tostring(level) .. ","
	end
	action.spawn_level = levels
	for i,chance in ipairs(action.spawn_probability_table) do
		chance = chance * multiplier
		probabilities = probabilities .. tostring(chance) .. ","
	end
	action.spawn_probability = probabilities
	table.insert(actions, action)
end