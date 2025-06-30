local util_technology = {}

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

function util_technology.replace(id, old, new)
	local tech = data.raw["technology"][id]
	if (tech == nil) then
		return
	end

	for _, effect in ipairs(tech.effects or {}) do
		if (effect.type == "unlock-recipe" and effect.recipe == old) then
			effect.recipe = new
		end
	end
end

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

return util_technology