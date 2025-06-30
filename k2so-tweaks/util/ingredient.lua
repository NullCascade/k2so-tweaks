local util_ingredient = {}

function util_ingredient.get_amount(ingredient)
	if (#ingredient == 0) then
		return ingredient.amount
	else
		return ingredient[2]
	end
end

function util_ingredient.set_amount(ingredient, amount)
	if (#ingredient == 0) then
		ingredient.amount = assert(amount)
	else
		ingredient[2] = assert(amount)
	end
end

function util_ingredient.get_name(ingredient)
	if (#ingredient == 0) then
		return assert(ingredient.name)
	else
		return assert(ingredient[1])
	end
end

function util_ingredient.set_name(ingredient, name)
	if (#ingredient == 0) then
		ingredient.name = name
	else
		ingredient[1] = name
	end
end

function util_ingredient.get_type(ingredient)
	if (#ingredient == 0) then
		return ingredient.type or "item"
	else
		return "item"
	end
end

return util_ingredient