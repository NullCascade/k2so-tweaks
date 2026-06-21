
local util = require("k2so-tweaks.util")

local patch = util.patch.new_patch("consistent-crafting-recipes")

local function copy_crafting_categories(from, to)
	local from_prototype = data.raw["assembling-machine"][from]
	local to_prototype = data.raw["assembling-machine"][to]
	if (not from_prototype or not to_prototype) then
		return
	end

	for _, category in ipairs(from_prototype.crafting_categories) do
		if (util.table.insert_unique(to_prototype.crafting_categories, category)) then
			util.log("Added category '%s' to assembling machine '%s'", category, to)
		end
	end
end

function patch.on_data_final_fixes()
	-- Fixup K2's crafting machines to work with any custom categories that were added to assembling machines.
	copy_crafting_categories("assembling-machine-3", "kr-advanced-assembling-machine")
	copy_crafting_categories("chemical-plant", "kr-advanced-chemical-plant")
	copy_crafting_categories("electric-furnace", "kr-advanced-furnace")
	copy_crafting_categories("foundry", "kr-advanced-furnace")

	-- If using xyrc's K2SO Enhancements...
	if (util.setting_equal("xy-adv-chem-plant-rebalance", true)) then
		copy_crafting_categories("kr-advanced-chemical-plant", "electrochemical-plant")
	end
end
