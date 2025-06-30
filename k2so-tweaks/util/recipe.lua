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
	error("Needs to be rewritten for 2.0")
end

--- Disallows the use of a module by a given recipe.
--- @param module string The substring name for the module.
--- @param recipe_name string The id of the recipe.
function util_recipe.disallow_module(module, recipe_name)
	error("Needs to be rewritten for 2.0")
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

	for ingredient_index, ingredient in ipairs(recipe.ingredients or {}) do
		if (util_ingredient.get_name(ingredient) == search_ingredient and util_ingredient.get_type(ingredient) == type) then
			return ingredient, ingredient_index
		end
	end
end

function util_recipe.add_ingredient(recipe_name, ingredient_name, amount, type)
	local recipe = data.raw.recipe[recipe_name]
	if (recipe == nil) then
		return false
	end

	if (recipe.ingredients == nil) then
		recipe.ingredients = {}
	end

	table.insert(recipe.ingredients, { type = type, name = ingredient_name, amount = amount })
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

	if (not recipe.ingredients) then
		return false
	end

	local _, ingredient_index = util_recipe.find_ingredient(recipe_name, ingredient_name, type)
	if (not ingredient_index) then
		return false
	end

	table.remove(recipe.ingredients, ingredient_index)
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

--- @param old string
--- @param new string
--- @param type string
function util_recipe.replace_all(old, new, type)
	local util = require("k2so-tweaks.util")

	for id, recipe in pairs(data.raw["recipe"]) do
		util.recipe.replace_ingredient_in_place(id, old, new, type)
		if recipe.main_product == old then
			recipe.main_product = new
		end
		for _, result in ipairs(recipe.results or {}) do
			if (result.name == old and result.type == type) then
				result.name = new
			end
		end
	end
end

--- @param recipe_name string
--- @param category string
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

--- Creates a copy of a recipe.
--- @param recipe_name string
--- @param copy_name string
--- @return data.RecipePrototype
function util_recipe.clone(recipe_name, copy_name)
	assert(data.raw["recipe"][recipe_name], "Recipe to clone does not exist")
	assert(data.raw["recipe"][copy_name] == nil, "A recipe of this name already exists")
	local recipe = table.deepcopy(data.raw["recipe"][recipe_name])
	recipe.name = copy_name
	data:extend({ recipe })
	return recipe
end

--- @param recipe_name string
--- @param primary_item_name string
--- @param secondary_item_name string
function util_recipe.set_standardized_dual_icon(recipe_name, primary_item_name, secondary_item_name)
	local util = require("k2so-tweaks.util")

	data.raw["recipe"][recipe_name].icon = nil
	data.raw["recipe"][recipe_name].icons = util.item.create_dual_icon(primary_item_name, secondary_item_name)
end

return util_recipe