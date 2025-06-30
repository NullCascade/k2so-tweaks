local util_fluid = {}

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
	new_entity.hidden = false
end

return util_fluid