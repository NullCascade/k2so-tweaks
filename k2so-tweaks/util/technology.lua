local util_technology = {}

function util_technology.add_recipe_unlock(technology, recipe)
	assert(type(technology) == "string")
	assert(type(recipe) == "string")

	local tech = data.raw.technology[technology]
	if (not tech) then
		return
	end

	table.insert(tech.effects, { type = "unlock-recipe", recipe = recipe })
end

return util_technology