local util_item = {}

function util_item.replace_all(old, new)
	local util = require("k2so-tweaks.util")
	util.log("Replacing all '%s' with '%s'", old, new)

	local old_entity = data.raw["item"][old]
	if (not old_entity) then
		return
	end
	local new_entity = data.raw["item"][new]
	assert(new_entity, "Replacement item does not exist!")

	util.recipe.replace_all(old, new)
	util.minable.replace_all(old, new)

	old_entity.hidden = true
	new_entity.hidden = false

	-- As a help to mid-save changes, make the old item spoil into the new item.
	if (new_entity.spoil_result ~= old_entity) then
		old_entity.spoil_result = new
		old_entity.spoil_ticks = 1
	end
end

return util_item