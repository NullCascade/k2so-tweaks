local util_fluid = {}

local flare_stack_lib = require("__Krastorio2-spaced-out__.prototypes.libraries.flare-stack")

function util_fluid.replace_all(old, new)
	local util = require("k2so-tweaks.util")
	util.log("Replacing all '%s' with '%s'", old, new)

	local old_entity = data.raw["fluid"][old]
	if (not old_entity) then
		return
	end
	local new_entity = data.raw["fluid"][new]
	assert(new_entity, "Replacement fluid does not exist!")

	util.recipe.replace_all(old, new, "fluid")
	util.minable.replace_all(old, new)

	old_entity.hidden = true
	old_entity.hidden_in_factoriopedia = true
	new_entity.hidden = false
	new_entity.hidden_in_factoriopedia = false

	-- Copy flare stack data
	do
		if (flare_stack_lib.is_blacklisted(old)) then
			flare_stack_lib.add_blacklist(new)
		end

		local byproducts = flare_stack_lib.get_byproducts(old)
		if (byproducts) then
			flare_stack_lib.set_byproducts(new, byproducts)
		end

		local emissions = flare_stack_lib.get_fluid_emissions_multiplier(old)
		if (emissions) then
			flare_stack_lib.set_fluid_emissions_multiplier(new, emissions)
		end

		util.recipe.remove("kr-burn-" .. old)
	end
end

return util_fluid