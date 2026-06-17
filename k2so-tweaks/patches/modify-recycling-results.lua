local util = require("k2so-tweaks.util")

local patch = util.patch.new_patch("modify-recycling-results")
patch:add_required_startup_setting_equal("nulls-k2so-modify-recycling-results", true)

--- @param item string
local function ensure_reset(item)
	if util.recycling.has_result(item, item) then
		return
	end

	util.log("Resetting item '%s' to self-recycle.", item)
	util.recycling.reset_to_self_recycle(item)
end

function patch.on_data_final_fixes()
	-- Automatic Train Painter: Alters electronic circuits to recycle to manual color modules. Reverts to vanilla.
	if (util.recycling.has_result("electronic-circuit", "manual-color-module")) then
		util.recycling.set_results("electronic-circuit", {
			{ type = "item", name = "iron-plate", amount = 0, extra_count_fraction = 0.25 },
			{ type = "item", name = "copper-cable", amount = 0, extra_count_fraction = 0.75 },
		})
	end

	-- Moshine: Causes processing units to recycle to silicon cell. Switch to recycling for K2's recipe.
	if (util.recycling.has_result("processing-unit", "silicon-cell")) then
		util.recycling.set_results("processing-unit", {
			{ type = "item", name = "advanced-circuit", amount = 0, extra_count_fraction = 0.25 },
			{ type = "item", name = "kr-rare-metals", amount = 0, extra_count_fraction = 0.75 },
		})
	end

	-- Ensure that base ores aren't set to something weird by another planet.
	ensure_reset("calcite")
	ensure_reset("carbon")
	ensure_reset("coal")
	ensure_reset("copper-ore")
	ensure_reset("ice")
	ensure_reset("iron-ore")
	ensure_reset("stone")
	ensure_reset("sulfur")
	ensure_reset("kr-imersite")
	ensure_reset("kr-rare-metal-ore")
end
