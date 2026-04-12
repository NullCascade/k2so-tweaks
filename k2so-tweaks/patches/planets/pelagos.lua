--[[
Features: 
	- Coconuts in greenhouses
	- Change corrosive firearm magazines to be in line with K2. Update graphic.
Todo:
	- Diesel greenhouse
	- Biomass or fertilizer from local resources
--]]


local util = require("k2so-tweaks.util")

local patch = util.patch.new_patch("planet-pelagos")
patch:add_required_mod("pelagos")


function patch.on_data()
	local greenhouse_batch_mult = 6

	-- Core extensions.
	data:extend({
		-- Add a recipe to grow coconuts with fertilizer.
		{
			type = "recipe",
			name = "k2sotweak-coconut-greenhouse",
			icons = util.graphics.create_dual_icon("item", "coconut", "item", "kr-greenhouse"),
			subgroup = "raw-resource",
			order = "a[coconut-with-fertilizer]",
			enabled = false,
			category = "kr-growing",
			energy_required = 60,
			ingredients = {
				{ type = "fluid", name = "water", amount = 600 * greenhouse_batch_mult },
				{ type = "item", name = "kr-fertilizer", amount = 1 * greenhouse_batch_mult },
				{ type = "item", name = "coconut-seed", amount = 1 * greenhouse_batch_mult },
			},
			results = {
				{ type = "item", name = "coconut", amount = 10 * greenhouse_batch_mult },
				{ type = "item", name = "wood", amount = 5 * greenhouse_batch_mult },
			},
			auto_recycle = false,
			main_product = "coconut",
			surface_conditions = {
				{ property = "pressure", min = 1809, max = 1809 },
			},
		},
		-- Add the technology to unlock the above recipe.
		{
			type = "technology",
			name = "k2sotweak-pelagos-greenhouse",
			icons = {
				{ icon = "__Krastorio2Assets__/technologies/greenhouse.png", icon_size = 256 },
				{ icon = "__pelagos__/graphics/palm/palm-tree-5.png", scale = 1/8, shift = { -32, 16 }, icon_size = 1024, floating = true, },
				{ icon = "__pelagos__/graphics/palm/palm-tree-2.png", scale = 1/8, shift = { 32, 16 }, icon_size = 1024, floating = true, },
			},
			unit = {
				time = 60,
				count = 1000,
				ingredients = {
					{ "production-science-pack", 1 },
					{ "utility-science-pack", 1 },
					{ "space-science-pack", 1 },
					{ "kr-advanced-tech-card", 1 },
					{ "agricultural-science-pack", 1 },
					{ "pelagos-science-pack", 1 },
				},
			},
			prerequisites = { "pelagos-science-pack", "kr-advanced-tech-card" },
			effects = {
				{ type = "unlock-recipe", recipe = "k2sotweak-coconut-greenhouse" },
			},
		},
	})

	-- Buff damage and magazine size to be in line with Krastorio's damage values.
	local corrosive_ammo = data.raw["ammo"]["corrosive-firearm-magazine"]
	if (corrosive_ammo) then
		util.recipe.replace_ingredient_in_place("corrosive-firearm-magazine", "firearm-magazine", "kr-rifle-magazine", "item")
		util.ammo.set_magazine_size("corrosive-firearm-magazine", 30)
		util.ammo.update_damage("corrosive-firearm-magazine", 8, 10, "corrosive")
		corrosive_ammo.icon = "__nulls-k2so-tweaks__/graphics/ammo/corrosive-rifle-magazine.png"
		corrosive_ammo.order = "a[basic-clips]-a06[rifle-magazine]"
	end

	-- Buff the heavy gun turret as well to be in line with Krastorio's direction.
	local heavy_gun_turret = data.raw["ammo-turret"]["heavy-gun-turret"]
	if (heavy_gun_turret) then
		heavy_gun_turret.attack_parameters.cooldown = 3
		heavy_gun_turret.max_health = 1500

		-- Only increase range if the realistic weapons setting is enabled.
		if (util.setting_equal("kr-realistic-weapons", true)) then
			heavy_gun_turret.attack_parameters.range = 28
		end
	end
end

function patch.on_data_final_fixes()
	-- Make heavy gun turrets match normal gun turrets for damage scaling techs.
	local heavy_gun_turret = data.raw["ammo-turret"]["heavy-gun-turret"]
	if (heavy_gun_turret) then
		for tech_id, _ in pairs(data.raw["technology"]) do
			util.technology.copy_effect(tech_id, "turret_id", "gun-turret", "heavy-gun-turret", "modifier")
		end
	end
end
