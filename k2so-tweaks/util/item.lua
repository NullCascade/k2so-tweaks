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

	util.recipe.replace_all(old, new, "item")
	util.minable.replace_all(old, new)

	old_entity.hidden = true
	new_entity.hidden = false

	-- As a help to mid-save changes, make the old item spoil into the new item.
	if (new_entity.spoil_result ~= old_entity) then
		old_entity.spoil_result = new
		old_entity.spoil_ticks = 1
	end
end

function util_item.get_icon(item_name)
	local item = data.raw["item"][item_name]
	if (item == nil) then
		return nil
	end

	if (item.icon) then
		return item.icon
	end

	if (item.icons and #item.icons > 0) then
		return item.icons[1].icon
	end

	return nil
end

function util_item.create_dual_icon(primary_item_name, secondary_item_name)
	local primary_icon = assert(util_item.get_icon(primary_item_name), "Primary item does not exist")
	local secondary_icon = assert(util_item.get_icon(secondary_item_name), "Secondary item does not exist")
	return {
		{ icon = primary_icon },
		{ icon = secondary_icon, scale = 0.22, shift = { -8, -8 }, },
	}
end

return util_item