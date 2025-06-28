--[[
Vanilla:
	- Direct Smelt: 100% effective (60 plates = 60 ore)
	- Molten: 225% effective (60 plates = 26.6 ore + 0.5 calcite)
Krastorio 2:
	- Direct Smelt: 50% effective (60 plates = 120 ore)
	- Enriched Smelt: 67% effective (60 plates + 0.7 stone = 89.7 ore + 30 sulfuric acid)
	- Molten: 225% effective (60 plates = 26.6 ore + 0.5 calcite) [vanilla]
	- Molten Enriched: 283% effective (60 plates = 21.2 ore + 0.3 calcite + 7.1 sulfuric acid)
Crushing Industry:
	- Direct Smelt: 100% effective (60 plates = 60 ore)
	- Crushed Smelt: 158% effective (60 plates = 38 ore)
	- Crushed Smelt (Big): 237% effective (60 plates = 25.3 ore)
	- Molten Crushed: 237% effective (60 plates = 25.3 ore + 0.5 calcite)
	- Molten Crushed (Big): 357% effective (60 plates = 16.8 ore + 0.5 calcite)
Krastorio 2 + Crushing Industry:
	- Direct Smelt: 50% effective (60 plates = 120 ore)
	- Enriched Smelt: 67% effective (60 plates + 0.7 stone = 89.7 ore + 30 sulfuric acid)
	- Crushed Smelt: 158% effective (60 plates = 38 ore)
	- Crushed Smelt (Big): 237% effective (60 plates = 25.3 ore)
	- Molten Crushed: 237% effective (60 plates = 25.3 ore + 0.5 calcite)
	- Molten Enriched: 283% effective (60 plates = 21.2 ore + 0.3 calcite + 7.1 sulfuric acid)
	- Molten Crushed (Big): 357% effective (60 plates = 16.8 ore + 0.5 calcite)
Krastorio 2 + Crushing Industry + This Mod:
	- Direct Smelt: 50% effective (60 plates = 120 ore)
	- Crushed Smelt: 78.9% effective (60 plates = 76 ore)
	- Crushed Smelt (Big): 84.3% effective (60 plates = 50.6 ore)
	- Enriched Crushed Smelt (Big): 157% effective (60 plates = 38 ore)
	- Molten Crushed: 237% effective (60 plates = 25.3 ore + 0.5 calcite)
	- Molten Enriched: 283% effective (60 plates = 21.2 ore + 0.3 calcite + 7.1 sulfuric acid)
	- Molten Crushed (Big): 357% effective (60 plates = 16.8 ore + 0.5 calcite)
	- Molten Enriched Crushed: 444% effective (60 plates = 13.5 ore + 0.3 calcite + 7.1 sulfuric acid)
	- Molten Enriched Crushed (Big): 674% effective (60 plates = 8.9 ore + 0.3 calcite + 7.1 sulfuric acid)

This tweak changes it so that:
	- Do a K2-style nerf to crushed smelting (2 crushed -> 1 plate)
	- Adds a recipe to enrich crushed ore for bigger returns
--]]

local util = require("k2so-tweaks.util")

local patch = util.patch.new_patch("crushing-industry")
patch:add_required_mod("crushing-industry")
patch:add_required_startup_setting_equal("nulls-k2so-crushing-industry-ratios", true)

function patch.on_data()
	data:extend({
		{
			type = "recipe",
			name = "kr-enriched-crushed-iron",
			icons = {
				{ icon = "__Krastorio2Assets__/icons/items/enriched-iron.png" },
				{
					icon = "__crushing-industry__/graphics/icons/crushed-iron-ore.png",
					scale = 0.22,
					shift = { -8, -8 },
				},
			},
			enabled = false,
			category = "chemistry",
			energy_required = 3,
			ingredients = {
				{ type = "fluid", name = "sulfuric-acid",    amount = 3 },
				{ type = "fluid", name = "water",            amount = 25 },
				{ type = "item",  name = "crushed-iron-ore", amount = 6 },
			},
			results = {
				{ type = "item",  name = "kr-enriched-iron", amount = 6 },
				{ type = "fluid", name = "kr-dirty-water",   amount = 25, ignored_by_productivity = 25 },
			},
			allow_productivity = true,
			always_show_made_in = true,
			always_show_products = true,
			crafting_machine_tint = {
				primary = { r = 0.25, g = 0.50, b = 0.65, a = 0.200 },
				secondary = { r = 0.50, g = 0.70, b = 0.90, a = 0.357 },
				tertiary = { r = 0.10, g = 0.25, b = 0.50, a = 0.100 },
				quaternary = { r = 0.25, g = 0.50, b = 0.65, a = 0.850 },
			},
			subgroup = "raw-material",
			order = "e02[enriched-iron]",
			auto_recycle = false,
		},
		{
			type = "recipe",
			name = "kr-enriched-crushed-copper",
			icons = {
				{ icon = "__Krastorio2Assets__/icons/items/enriched-copper.png" },
				{
					icon = "__crushing-industry__/graphics/icons/crushed-copper-ore.png",
					scale = 0.22,
					shift = { -8, -8 },
				},
			},
			enabled = false,
			category = "chemistry",
			energy_required = 3,
			ingredients = {
				{ type = "fluid", name = "sulfuric-acid",      amount = 3 },
				{ type = "fluid", name = "water",              amount = 25 },
				{ type = "item",  name = "crushed-copper-ore", amount = 9 },
			},
			results = {
				{ type = "item",  name = "kr-enriched-copper", amount = 6 },
				{ type = "fluid", name = "kr-dirty-water",     amount = 25, ignored_by_productivity = 25 },
			},
			allow_productivity = true,
			always_show_made_in = true,
			always_show_products = true,
			crafting_machine_tint = {
				primary = { r = 0.970, g = 0.501, b = 0.000, a = 0.000 },
				secondary = { r = 0.200, g = 0.680, b = 0.300, a = 0.357 },
				tertiary = { r = 0.430, g = 0.305, b = 0.2, a = 0.000 },
				quaternary = { r = 0.970, g = 0.501, b = 0.000, a = 0.900 },
			},
			subgroup = "raw-material",
			order = "e02[enriched-copper]",
			auto_recycle = false,
		},
	})

	-- Add the above recipes to the K2 enriched ore tech
	util.technology.add_recipe_unlock("kr-enriched-ores", "kr-enriched-crushed-iron")
	util.technology.add_recipe_unlock("kr-enriched-ores", "kr-enriched-crushed-copper")
end

function patch.on_data_final_fixes()
	util.recipe.replace_ingredient_amount("crushed-iron-smelting", "crushed-iron-ore", 2, "item")
	util.recipe.replace_ingredient_amount("crushed-copper-smelting", "crushed-copper-ore", 2, "item")
end

return patch
