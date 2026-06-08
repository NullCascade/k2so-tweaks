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

local recipes_to_modify = {
	"crushed-ore-smelting-productivity-1",
	"crushed-ore-smelting-productivity-2",
	"crushed-ore-smelting-productivity-3",
	"molten-crushed-ore-productivity",
}

local recipe_extensions = {
	["crushed-iron-smelting"] = { "kr-iron-plate-from-enriched-iron" },
	["crushed-copper-smelting"] = { "kr-copper-plate-from-enriched-copper" },
	["molten-iron"] = { "molten-enriched-iron" },
	["molten-copper"] = { "molten-enriched-copper" },
}

--- @param name string
local function handle_technology(name)
	local prototype = data.raw["technology"][name]
	if (prototype == nil) then
		return
	end

	local effects_to_add = {}
	for _, effect in ipairs(prototype.effects or {}) do
		if (effect.type == "change-recipe-productivity") then
			for _, recipe in ipairs(recipe_extensions[effect.recipe] or {}) do
				if (data.raw["recipe"][recipe]) then
					local to_add = table.deepcopy(effect)
					to_add.recipe = recipe
					table.insert(effects_to_add, to_add)
				else
					util.log("WARNING: Productivity research cloning failed. No recipe '%s' exists.", recipe)
				end
			end
		end
	end

	if (#effects_to_add > 0) then
		util.log("Extending bonus for enriched productivity to technology '%s'.", name)
	end

	for _, effect in ipairs(effects_to_add) do
		if (not util.technology.has_effect(name, effect)) then
			table.insert(prototype.effects, effect)
		end
	end
end

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

	-- Allow Imersite Asteroids to be crushed normally if the mod is available.
	util.recipe.add_additional_category("imersite-asteroid-crushing", "basic-crushing")

	-- Add productivity for K2SO enriched ores in crushing industry.
	for _, name in ipairs(recipes_to_modify) do
		handle_technology(name)
	end
end

return patch