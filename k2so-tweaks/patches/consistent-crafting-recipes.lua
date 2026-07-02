
local util = require("k2so-tweaks.util")

local patch = util.patch.new_patch("consistent-crafting-recipes")

function patch.on_data_final_fixes()
	-- Fixup K2's crafting machines to work with any custom categories that were added to assembling machines.
	util.assembler.copy_crafting_categories("assembling-machine-3", "kr-advanced-assembling-machine")
	util.assembler.copy_crafting_categories("chemical-plant", "kr-advanced-chemical-plant")
	util.assembler.copy_crafting_categories("electric-furnace", "kr-advanced-furnace")
	util.assembler.copy_crafting_categories("foundry", "kr-advanced-furnace")

	-- If using xyrc's K2SO Enhancements...
	if (util.setting_equal("xy-adv-chem-plant-rebalance", true)) then
		util.assembler.copy_crafting_categories("kr-advanced-chemical-plant", "electrochemical-plant")
	end
end
