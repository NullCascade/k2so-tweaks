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
	- Enriched Smelt: 67% effective (60 plates + 0.7 stone = 89.7 ore + 30 sulfuric acid)
	- Crushed Smelt: 78.9% effective (60 plates = 76 ore)
	- Crushed Smelt (Big): 84.3% effective (60 plates = 50.6 ore)
	- Enriched Crushed Smelt: 186% effective (60 plates = 32.2 ore + 15 sulfuric acid)
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

local patch = util.patch.new_patch("mod-crushing-industry-ratios")
patch:add_required_mod("crushing-industry")
patch:add_required_startup_setting_equal("nulls-k2so-crushing-industry-ratios", true)

function patch.on_data()
	-- Enriched crushed iron
	util.recipe.clone("kr-enriched-iron", "kr-enriched-crushed-iron")
	util.recipe.replace_ingredient_in_place("kr-enriched-crushed-iron", "iron-ore", "crushed-iron-ore", "item")
	util.recipe.set_standardized_dual_icon("kr-enriched-crushed-iron", "kr-enriched-iron", "crushed-iron-ore")
	util.technology.add_recipe_unlock("kr-enriched-ores", "kr-enriched-crushed-iron")

	-- Enriched crushed copper
	util.recipe.clone("kr-enriched-copper", "kr-enriched-crushed-copper")
	util.recipe.replace_ingredient_in_place("kr-enriched-crushed-copper", "copper-ore", "crushed-copper-ore", "item")
	util.recipe.set_standardized_dual_icon("kr-enriched-crushed-copper", "kr-enriched-copper", "crushed-copper-ore")
	util.technology.add_recipe_unlock("kr-enriched-ores", "kr-enriched-crushed-copper")
end

function patch.on_data_final_fixes()
	-- Use K2 style 2:1 smelting for crushed ore smelting.
	util.recipe.replace_ingredient_amount("crushed-iron-smelting", "crushed-iron-ore", 2, "item")
	util.recipe.replace_ingredient_amount("crushed-copper-smelting", "crushed-copper-ore", 2, "item")
end

return patch
