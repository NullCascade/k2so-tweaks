
local util = require("k2so-tweaks.util")

local patch = util.patch.new_patch("planet-maraxsis")
patch:add_required_mod("maraxsis")
patch:add_required_startup_setting_equal("nulls-k2so-maraxsis-quantum-revert", true)

function patch.on_data_final_fixes()
	local recipe = data.raw["recipe"]["kr-quantum-computer"]
	if (recipe) then
		recipe.localised_name = {"entity-name.kr-quantum-computer-reverted"}
		recipe.category = "cryogenics"
		recipe.ingredients = {
			{ type = "item", name = "kr-rare-metals", amount = 50 },
			{ type = "item", name = "kr-ai-core", amount = 50 },
			{ type = "item", name = "steel-plate", amount = 100 },
			{ type = "item", name = "quantum-processor", amount = 100 },
			{ type = "fluid", name = "fluoroketone-cold", amount = 100 },
		}
	end

	local machine = data.raw["assembling-machine"]["kr-quantum-computer"]
	if (machine) then
		machine.localised_name = {"entity-name.kr-quantum-computer-reverted"}
		machine.effect_receiver.base_effect.quality = nil
		machine.energy_usage = "5MW"
		util.table.remove_with_keyvalues(machine.surface_conditions, { property = "pressure" })
		util.table.remove_with_keyvalues(machine.tile_buildability_rules, { is_maraxsis_rule = true })
	end

	local technology = data.raw["technology"]["kr-quantum-computer"]
	if (technology) then
		technology.localised_name = {"entity-name.kr-quantum-computer-reverted"}
		technology.localised_description = {"technology-description.kr-quantum-computer-reverted"}
		util.table.remove_with_keyvalues(technology.unit.ingredients, { [1] = "hydraulic-science-pack" })
		util.table.remove_value(technology.prerequisites, "maraxsis-project-seadragon")
	end
end

return patch