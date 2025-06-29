local util_recipe = {}
local util_table = require("k2so-tweaks.util.table")
local util_ingredient = require("k2so-tweaks.util.ingredient")

local limitation_strings = {
	effectivity = "efficiency-module-not-allowed",
}

--- Allows the use of a module by a given recipe.
--- @param module string The substring name for the module.
--- @param recipe_name string The id of the recipe.
function util_recipe.allow_module(module, recipe_name)
	local recipe = data.raw.recipe[recipe_name]
	if (recipe == nil) then
		return
	end

	for _, prototype in pairs(data.raw["module"]) do
		if (prototype.limitation_blacklist and string.find(prototype.name, module, 1, true)) then
			local limitation_message_key = limitation_strings[module]
			if (limitation_message_key and prototype.limitation_message_key == limitation_message_key) then
				prototype.limitation_message_key = nil
			end
			util_table.remove_value(prototype.limitation_blacklist, recipe_name)
		end
	end
end

--- Disallows the use of a module by a given recipe.
--- @param module string The substring name for the module.
--- @param recipe_name string The id of the recipe.
function util_recipe.disallow_module(module, recipe_name)
	local recipe = data.raw.recipe[recipe_name]
	if (recipe == nil) then
		return
	end

	for _, prototype in pairs(data.raw["module"]) do
		if (string.find(prototype.name, module, 1, true)) then
			local limitation_message_key = limitation_strings[module]
			if (limitation_message_key and prototype.limitation_message_key == nil) then
				prototype.limitation_message_key = limitation_message_key
			end

			prototype.limitation_blacklist = prototype.limitation_blacklist or {}
			if not util_table.contains(prototype.limitation_blacklist, recipe_name) then
				table.insert(prototype.limitation_blacklist, recipe_name)
			end
		end
	end
end

--- Gets the ingredients table for a given recipe.
--- @param recipe_name string The name of the recipe.
--- @return table?
function util_recipe.get_ingredient_table(recipe_name)
	local recipe = data.raw.recipe[recipe_name]
	if (recipe == nil) then
		return
	end

	return recipe.ingredients
end

--- Returns the ingredient entry for a given recipe.
--- @param recipe_name string
--- @param search_ingredient string
--- @param type string
--- @return data.IngredientPrototype|nil ingredient
--- @return integer|nil ingredient_index
function util_recipe.find_ingredient(recipe_name, search_ingredient, type)
	local recipe = data.raw.recipe[recipe_name]
	if (recipe == nil) then
		return
	end

	local ingredients = util_recipe.get_ingredient_table(recipe_name)
	for ingredient_index, ingredient in ipairs(ingredients or {}) do
		if (util_ingredient.get_name(ingredient) == search_ingredient and util_ingredient.get_type(ingredient) == type) then
			return ingredient, ingredient_index
		end
	end
end

--- Removes an ingredient from a given recipe.
--- @param recipe_name string
--- @param ingredient_name string
--- @param type string The 
--- @return boolean success If true, the ingredient was removed.
function util_recipe.remove_ingredient(recipe_name, ingredient_name, type)
	local recipe = data.raw.recipe[recipe_name]
	if (recipe == nil) then
		return false
	end

	local ingredients = util_recipe.get_ingredient_table(recipe_name)
	if (not ingredients) then
		return false
	end

	local _, ingredient_index = util_recipe.find_ingredient(recipe_name, ingredient_name, type)
	if (not ingredient_index) then
		return false
	end

	table.remove(ingredients, ingredient_index)
	return true
end

--- Modifies the amount of an item needed for a given recipe. The item must already exist in the recipe.
--- @param recipe_name string
--- @param ingredient_name string
--- @param new_amount number
--- @param type string
--- @return boolean was_modified
function util_recipe.replace_ingredient_amount(recipe_name, ingredient_name, new_amount, type)
	local ingredient = util_recipe.find_ingredient(recipe_name, ingredient_name, type)
	if (not ingredient) then
		return false
	end

	util_ingredient.set_amount(ingredient, new_amount)
	return true
end

--- Wrapper around remove_ingredient and add_ingredient, which removes then adds a replacement ingredient.
--- @param recipe_name string The recipe name.
--- @param old_ingredient string The ingredient name to replace.
--- @param new_ingredient string The ingredient name to use instead.
--- @param amount number? The amount of the ingredient needed.
--- @param type string The ingredient type, defaulting to "item".
function util_recipe.replace_ingredient(recipe_name, old_ingredient, new_ingredient, amount, type)
	if (old_ingredient) then
		if (util_recipe.remove_ingredient(recipe_name, old_ingredient, type)) then
			util_recipe.add_ingredient(recipe_name, new_ingredient, amount, type)
		end
	else
		util_recipe.add_ingredient(recipe_name, new_ingredient, amount, type)
	end
end

--- A simple in-place ingredient swap.
--- @param recipe_name string The recipe name.
--- @param old_ingredient string The ingredient name to replace.
--- @param new_ingredient string The ingredient name to use instead.
--- @param ingredient_type string The ingredient type, defaulting to "item".
function util_recipe.replace_ingredient_in_place(recipe_name, old_ingredient, new_ingredient, ingredient_type)
	local ingredient = util_recipe.find_ingredient(recipe_name, old_ingredient, ingredient_type)
	if (ingredient == nil) then
		return
	end

	ingredient.name = new_ingredient
end

function util_recipe.replace_all(old, new)
	local util = require("k2so-tweaks.util")

	for id, recipe in pairs(data.raw["recipe"]) do
		util.recipe.replace_ingredient_in_place(id, old, new, "item")
		if recipe.main_product == old then
			recipe.main_product = new
		end
		for _, result in ipairs(recipe.results or {}) do
			if (result.name == old) then
				result.name = new
			end
		end
	end
end

function util_recipe.add_additional_category(recipe_name, category)
	local recipe = data.raw["recipe"][recipe_name]
	if (recipe == nil) then
		return
	end

	recipe.additional_categories = recipe.additional_categories or {}
	for _, existing in ipairs(recipe.additional_categories) do
		if (existing == category) then
			return
		end
	end

	table.insert(recipe.additional_categories, category)
end

return util_recipe