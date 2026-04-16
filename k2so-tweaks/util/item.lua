local util_item = {}

--- @param old string
--- @param new string
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
	old_entity.hidden_in_factoriopedia = true
	new_entity.hidden = false
	new_entity.hidden_in_factoriopedia = false

	-- As a help to mid-save changes, make the old item spoil into the new item.
	if (new_entity.spoil_result ~= old_entity) then
		old_entity.spoil_result = new
		old_entity.spoil_ticks = 1
	end
end

--- @param type_name string
--- @param name string
--- @param size number
function util_item.set_stack_size(type_name, name, size)
	local util = require("k2so-tweaks.util")

	local prototypes_of_type = data.raw[type_name]
	if (prototypes_of_type == nil) then
		return
	end

	local prototype = prototypes_of_type[name]
	if (prototype == nil) then
		util.log("Prototype '%s'/'%s' does not exist.", type_name, name)
		return
	end

	if (prototype.stack_size == nil) then
		util.log("Prototype '%s'/'%s' does not support stack sizes.", type_name, name)
		return
	end

	if (prototype.stack_size == size) then
		return
	end

	prototype.stack_size = size
end

return util_item