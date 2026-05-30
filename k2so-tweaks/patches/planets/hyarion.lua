
local util = require("k2so-tweaks.util")

local patch = util.patch.new_patch("planet-hyarion")
patch:add_required_mod("planetaris-hyarion")

function patch.on_data()
	-- Things like fusion power aren't allowed here.
	util.surface.enforce_condition("assembling-machine", "kr-fusion-reactor", "planetaris-crystalization-resistance", nil, 49)
	util.surface.enforce_condition("assembling-machine", "kr-antimatter-reactor", "planetaris-crystalization-resistance", nil, 49)

	-- Automation 4 is in a wierd place. It has more module slots than the advanced assembling machine, but a slower
	-- speed. For now, we just aren't going to touch it.
	-- util.recipe.replace_ingredient("kr-advanced-assembling-machine", "assembling-machine-3", "assembling-machine-4", 1, "item")
end

function patch.on_data_final_fixes()
	
end
