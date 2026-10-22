--[[
	- Require recipes to be selected in the burner/electric crushers.
	- Allows imersite to be processed in the burner/electric crushers.
TODO:
	- Add ore crushing for:
		- Krastorio 2: Rare Earth
		- Krastorio 2: Imersite? Already has crushing in K2...
		- <other planets>
--]]

local util = require("k2so-tweaks.util")

local patch = util.patch.new_patch("mod-crushing-industry")
patch:add_required_mod("crushing-industry")

local smelting_recipes = {
	"kr-iron-plate-from-enriched-iron",
	"kr-copper-plate-from-enriched-copper",
}

local molten_recipes = {
	"molten-enriched-iron",
	"molten-enriched-copper",
}

--- Modified from Krastorio 2's data_util library.
--- @param name string
local function require_recipe_selection(name)
	local furnace = data.raw["furnace"][name]
	if not furnace then
		util.log("Furnace %s does not exist.", name)
		return
	end

	local assembler = table.deepcopy(furnace) --[[@as data.AssemblingMachinePrototype]]
	assembler.type = "assembling-machine"
	assembler.source_inventory_size = nil --- @diagnostic disable-line
	assembler.energy_source.emissions_per_minute = assembler.energy_source.emissions_per_minute or { pollution = 2 }
	assembler.energy_usage = assembler.energy_usage or "0.2MW"
	data.raw["furnace"][name] = nil
	data:extend({ assembler })
	return assembler
end

function patch.on_data_final_fixes()
	-- Make the small crushers behave like the big crusher: recipes must be selected explicitly.
	require_recipe_selection("burner-crusher")
	require_recipe_selection("electric-crusher")

	-- Allow more things to be processed by crushing machines.
	util.recipe.add_additional_category("kr-imersite-powder", "basic-crushing")

	-- Allow more basic asteroid crushing from asteroid-adding mods.
	util.recipe.add_additional_category("auric-asteroid-crushing", "basic-crushing")
	util.recipe.add_additional_category("bismuth-asteroid-crushing", "basic-crushing")
	util.recipe.add_additional_category("imersite-asteroid-crushing", "basic-crushing")
	util.recipe.add_additional_category("organic-asteroid-crushing", "basic-crushing")
	util.recipe.add_additional_category("petrified-asteroid-crushing", "basic-crushing")
	util.recipe.add_additional_category("rock-asteroid-crushing", "basic-crushing")
	util.recipe.add_additional_category("scrap-asteroid-crushing", "basic-crushing")

	-- Add productivity for K2SO enriched ores in crushing industry.
	if (CrushingIndustry) then
		for _, tech_name in ipairs(smelting_recipes) do
			CrushingIndustry.add_smelting_productivity(tech_name)
		end
		for _, tech_name in ipairs(molten_recipes) do
			CrushingIndustry.add_molten_productivity(tech_name)
		end
	else
		util.log("Could not find CrushingIndustry API!")
	end
end

return patch