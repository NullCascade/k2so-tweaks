local util = require("k2so-tweaks.util")

local patch = util.patch.new_patch("k2so-thruster-fix-fix")
patch:add_required_mod("k2so-thruster-fix")

function patch.on_data_final_fixes()
	-- Ensure that Muluna's thruster fuel productivity research applies to the mod.
	local thruster_fuel_prod_tech = data.raw["technology"]["thruster-fuel-productivity"]
	if (thruster_fuel_prod_tech) then
		local recipes = {
			"reverted-thruster-fuel", "reverted-thruster-oxidizer",
			"reverted-advanced-thruster-fuel", "reverted-advanced-thruster-oxidizer",
		}
		for _, recipe in ipairs(recipes) do
			if (not util.table.has_keyvalues(thruster_fuel_prod_tech.effects, { type = "change-recipe-productivity", recipe = recipe })) then
				table.insert(thruster_fuel_prod_tech.effects, { type = "change-recipe-productivity", recipe = recipe, change = 0.1 })
			end
		end
	end
end

return patch