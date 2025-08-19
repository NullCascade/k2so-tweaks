local util = require("k2so-tweaks.util")

local patch = util.patch.new_patch("modify-recycling-results")
patch:add_required_startup_setting_equal("nulls-k2so-modify-recycling-results", true)

function patch.on_data_final_fixes()
	-- Metal and Stars: Alters carbon to recycle to thermophilic bacteria. Reverts to self-recycle.
	if (util.recycling.has_result("carbon", "thermo-bacteria")) then
		util.recycling.reset_to_self_recycle("carbon")
	end

	-- Automatic Train Painter: Alters electronic circuits to recycle to manual color modules. Reverts to vanilla.
	if (util.recycling.has_result("electronic-circuit", "manual-color-module")) then
		util.recycling.set_results("electronic-circuit", {
			{ type = "item", name = "iron-plate", amount = 0, extra_count_fraction = 0.25 },
			{ type = "item", name = "copper-cable", amount = 0, extra_count_fraction = 0.75 },
		})
	end

	-- ???: Ice recycles circularly to platforms? Make self-recycle.
	if (util.recycling.has_result("ice", "ice-platform")) then
		util.recycling.reset_to_self_recycle("ice")
	end

	-- Moshine: Causes processing units to recycle to silicon cell. Switch to recycling for K2's recipe.
	if (util.recycling.has_result("processing-unit", "silicon-cell")) then
		util.recycling.set_results("processing-unit", {
			{ type = "item", name = "advanced-circuit", amount = 0, extra_count_fraction = 0.25 },
			{ type = "item", name = "kr-rare-metals", amount = 0, extra_count_fraction = 0.75 },
		})
	end
end
