local util_technology = {}

--- @param technology string
--- @param recipe string
function util_technology.add_recipe_unlock(technology, recipe)
	assert(type(technology) == "string")
	assert(type(recipe) == "string")

	local tech = data.raw["technology"][technology]
	if (not tech) then
		return
	end

	for _, effect in ipairs(tech.effects) do
		-- Prevent duplicates
		if (effect.type == "unlock-recipe" and effect.recipe == recipe) then
			return
		end
	end

	table.insert(tech.effects, { type = "unlock-recipe", recipe = recipe })
end

--- @param id string
--- @param old string
--- @param new string
function util_technology.replace(id, old, new)
	local tech = data.raw["technology"][id]
	if (tech == nil) then
		return
	end

	-- Ensure that both recipes exist.
	local old_prototype = data.raw["recipe"][old]
	local new_prototype = data.raw["recipe"][new]
	if (not old_prototype or not new_prototype) then
		return
	end

	for _, effect in ipairs(tech.effects or {}) do
		if (effect.type == "unlock-recipe" and effect.recipe == old) then
			effect.recipe = new
		end
	end
end

--- @param old string
--- @param new string
function util_technology.replace_all_unlocks(old, new)
	if (data.raw["recipe"][old] == nil) then
		return
	end
	if (data.raw["recipe"][new] == nil) then
		return
	end

	for id, _ in pairs(data.raw["technology"]) do
		util_technology.replace(id, old, new)
	end
end

--- @param id any
--- @param effect any
function util_technology.has_effect(id, effect)
	local prototype = data.raw["technology"][id]
	if (prototype == nil) then
		return
	end

	local util = require("k2so-tweaks.util")
	for _, existing_effect in ipairs(prototype.effects or {}) do
		if util.table.match_all(effect, existing_effect) then
			return true
		end
	end

	return false
end

--- @param id string
--- @param replace_with string?
function util_technology.remove(id, replace_with)
	local prototype = data.raw["technology"][id]
	if (prototype == nil) then
		return
	end

	prototype.hidden = true
	prototype.hidden_in_factoriopedia = true

	local util = require("k2so-tweaks.util")
	for _, tech in pairs(data.raw["technology"]) do
		if (util.table.remove_value(tech.prerequisites or {}, id) and replace_with) then
			table.insert(tech.prerequisites, replace_with)
		end
	end
end

--- @param id string
function util_technology.remove_all_unlocks(id)
	local util = require("k2so-tweaks.util")
	for _, tech in pairs(data.raw["technology"]) do
		local to_remove = {}
		for _, effect in ipairs(tech.effects or {}) do
			if (effect.type == "unlock-recipe" and effect.recipe == id) then
				table.insert(to_remove, effect)
			end
		end
		for _, effect in ipairs(to_remove) do
			util.table.remove_value(tech.effects, effect)
		end
	end
end

--- @param id string
--- @param hidden boolean
function util_technology.set_hidden(id, hidden)
	local prototype = data.raw["technology"][id]
	if (prototype == nil) then
		return
	end

	prototype.hidden = hidden
end

return util_technology