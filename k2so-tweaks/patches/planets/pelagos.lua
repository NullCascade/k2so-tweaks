--[[
Features: 
	- Coconuts in greenhouses
	- Change corrosive firearm magazines to be in line with K2. Update graphic.
Todo:
	- Diesel greenhouse
--]]

local util = require("k2so-tweaks.util")

local patch = util.patch.new_patch("planet-pelagos")
patch:add_required_mod("pelagos")

local function support_modded_landfill()
	local technology = data.raw["technology"]["landfill-productivity"]
	if (technology == nil) then
		return
	end

	if (not technology.effects) then
		return
	end

	local standard_effect = util.table.find_keyvalues(technology.effects, { type = "change-recipe-productivity", recipe = "landfill" })
	if (not standard_effect) then
		return
	end

	-- Get a list of recipes to include.
	local landfill_recipes = util.recipe.get_with_result("item", "landfill", true)
	local unique_recipes = {}
	for _, recipe in ipairs(landfill_recipes) do
		unique_recipes[recipe] = true
	end
	unique_recipes["landfill"] = nil

	-- Filter out recipes already included.
	for _, effect in ipairs(technology.effects) do
		if (effect.type == "change-recipe-productivity") then
			unique_recipes[effect.recipe] = nil
		end
	end

	for recipe, _ in pairs(unique_recipes) do
		util.log("Adding landfill productivity to recipes: %s", recipe)
		local copy = table.deepcopy(standard_effect)
		copy.recipe = recipe
		table.insert(technology.effects, copy)
	end
end

local function expand_research()
	-- Piranha roe should be affected like larvae is.
	util.technology.copy_effect("cultivation-productivity", "recipe", "larvae-cultivation", "roe-reproduction", "change")
end

local function coconuts_in_greenhouses()
	local greenhouse_batch_mult = 6

	-- Core extensions.
	data:extend({
		-- Add a recipe to grow coconuts with fertilizer.
		{
			type = "recipe",
			name = "k2sotweak-coconut-greenhouse",
			icon = util.graphics.get_icon("item", "coconut"),
			subgroup = "raw-resource",
			order = "a[coconut-with-fertilizer]",
			enabled = false,
			categories = { "kr-growing" },
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
end

local function combat_changes_data()
	-- Buff damage and magazine size to be in line with Krastorio's damage values.
	local corrosive_ammo = data.raw["ammo"]["corrosive-firearm-magazine"]
	if (corrosive_ammo and util.setting_equal("kr-realistic-weapons", true)) then
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

--- @param type string
--- @param base string
--- @param new string
local function give_grid_if_missing(type, base, new)
	local base_entity = data.raw[type][base]
	local new_entity = data.raw[type][new]
	if (base_entity == nil) then
		util.log("Cannot assign equipment grid to '%s'/'%s': Base entity '%s' does not exist.", type, new, base)
		return
	elseif (new_entity == nil) then
		util.log("Cannot assign equipment grid to '%s'/'%s': Entity does not exist.", type, new)
		return
	elseif (new_entity.equipment_grid ~= nil) then
		util.log("Cannot assign equipment grid to '%s'/'%s': Entity already has equipment grid '%s'.", type, new, new_entity.equipment_grid)
		return
	end

	new_entity.equipment_grid = base_entity.equipment_grid
end

local function cargo_ship_equipment_grids()
	-- Cargo ships get base train grids.
	give_grid_if_missing("locomotive", "locomotive", "cargo_ship_engine")
	give_grid_if_missing("cargo-wagon", "cargo-wagon", "cargo_ship")
	give_grid_if_missing("fluid-wagon", "fluid-wagon", "oil_tanker")
end

local function combat_changes_final_fixes()
	-- Make heavy gun turrets match normal gun turrets for damage scaling techs.
	local heavy_gun_turret = data.raw["ammo-turret"]["heavy-gun-turret"]
	if (heavy_gun_turret) then
		for tech_id, _ in pairs(data.raw["technology"]) do
			util.technology.copy_effect(tech_id, "turret_id", "gun-turret", "heavy-gun-turret", "modifier")
		end
	end
end

function patch.on_data()
	coconuts_in_greenhouses()
	combat_changes_data()
end

function patch.on_data_final_fixes()
	support_modded_landfill()
	expand_research()
	combat_changes_final_fixes()
	cargo_ship_equipment_grids()
end
