local util_fluid = {}

function util_fluid.get_flare_stack_library()
	if (mods["Krastorio2"]) then
		return require("__Krastorio2__.prototypes.libraries.flare-stack")
	else
		return require("__Krastorio2-spaced-out__.prototypes.libraries.flare-stack")
	end
end

local function copy_flare_data(old, new)
	local flare_stack_lib = util_fluid.get_flare_stack_library()
	if (not flare_stack_lib) then
		return
	end

	local util = require("k2so-tweaks.util")
	if (data.raw["recipe"]["kr-burn-" .. new]) then
		return
	end

	local byproducts = flare_stack_lib.get_byproducts(old)
	local emissions = flare_stack_lib.get_fluid_emissions_multiplier(old)
	flare_stack_lib.make_recipe(new, emissions, byproducts)

	if (flare_stack_lib.is_blacklisted(old)) then
		flare_stack_lib.add_blacklist(new)
	end

	util.recipe.remove("kr-burn-" .. old)
end

local function replace_barrel(old, new, barrel_type)
	local util = require("k2so-tweaks.util")
	local old_barrel_id = string.format("%s-%s", old, barrel_type)
	local new_barrel_id = string.format("%s-%s", new, barrel_type)
	util.item.replace_all(old_barrel_id, new_barrel_id)
	util.recipe.remove(string.format("%s-%s", old, barrel_type))
	util.recipe.remove(string.format("empty-%s-%s", old, barrel_type))
end

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
	util.tile.replace_all(old, new)
	util.graphics.replace_all(old_entity.icon, new_entity.icon)

	old_entity.hidden = true
	old_entity.hidden_in_factoriopedia = true
	new_entity.hidden = false
	new_entity.hidden_in_factoriopedia = false

	-- Handle flaring.
	copy_flare_data(old, new)

	-- Handle barrels.
	replace_barrel(old, new, "barrel")
	replace_barrel(old, new, "titanium-barrel")
end

return util_fluid