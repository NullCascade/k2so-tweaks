
local util = require("k2so-tweaks.util")

local patch = util.patch.new_patch("planet-maraxsis")
patch:add_required_mod("maraxsis")

function copy_buildability_rules(type, from, to)
	local prototype_from = data.raw[type][from]
	local prototype_to = data.raw[type][to]
	if (not prototype_from) then
		util.log("Could copy maraxsis compatibility from %s: Prototype does not exist.", from, to)
		return
	elseif (not prototype_to) then
		util.log("Could copy maraxsis compatibility to %s: Prototype does not exist.", from, to)
		return
	end

	prototype_to.maraxsis_buildability_rules = prototype_from.maraxsis_buildability_rules
end

function patch.on_data()
	-- Allow certain other buildings to function in water.
	copy_buildability_rules("assembling-machine", "chemical-plant", "kr-advanced-chemical-plant")
end

function patch.on_data_final_fixes()
	-- Atmosphere is obtained using atmosphere condensation
	-- TODO: The atmosphere condensation machine can't be placed in a way that is compatible with this. Figure it out later.
	util.recipe.add_additional_category("maraxsis-atmosphere", "kr-atmosphere-condensation")

	-- Electrolysis is done in the electrolysis plant
	data.raw["recipe"]["salt"].category = "kr-electrolysis"
end

return patch