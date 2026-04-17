local util_matter = {}

function util_matter.get_matter_library()
	return require("__Krastorio2-spaced-out__.prototypes.libraries.matter")
end

--- @param technology_id string
--- @param entity_type string
--- @param entity_id string
--- @param entity_amount number
--- @param matter_amount number
function util_matter.make_recipes(technology_id, entity_type, entity_id, entity_amount, matter_amount)
	local util = require("k2so-tweaks.util")

	if (data.raw[entity_type][entity_id] == nil) then
		util.log("Cannot make matter recipes. '%s/%s' does not exist.", entity_id, entity_type)
		return
	end

	if (data.raw["technology"][technology_id] == nil) then
		util.log("Technology '%s' does not exist when creating matter recipes for '%s/%s'.", technology_id, entity_id, entity_type)
		return
	end

	local matter_lib = util_matter.get_matter_library()
	matter_lib.make_recipes({
		material = { type = entity_type, name = entity_id, amount = entity_amount },
		matter_count = matter_amount,
		energy_required = 2,
		unlocked_by = technology_id,
	})
end

--- @param technology_id string
--- @param entity_type string
--- @param entity_id string
--- @param entity_amount number
--- @param matter_amount number
function util_matter.make_deconversion_recipe(technology_id, entity_type, entity_id, entity_amount, matter_amount)
	local util = require("k2so-tweaks.util")

	if (data.raw[entity_type][entity_id] == nil) then
		util.log("Cannot make deconversion matter recipe. '%s/%s' does not exist.", entity_id, entity_type)
		return
	end

	if (data.raw["technology"][technology_id] == nil) then
		util.log("Technology '%s' does not exist when creating matter deconversion for '%s/%s'.", technology_id, entity_id, entity_type)
		return
	end

	local matter_lib = util_matter.get_matter_library()
	matter_lib.make_deconversion_recipe({
		material = { type = entity_type, name = entity_id, amount = entity_amount },
		matter_count = matter_amount,
		energy_required = 2,
		unlocked_by = technology_id,
	})
end

local function make_matter_icon(icon_path)
	local util = require("k2so-tweaks.util")
	return {
		{ icon = util.graphics.get_icon("fluid", "kr-matter") },
		{ icon = icon_path, scale = 0.85 },
	}
end

--- @param params table
function util_matter.make_technology(params)
	local ingredients = {
		{ "production-science-pack", 1 },
		{ "utility-science-pack", 1 },
		{ "space-science-pack", 1 },
		{ "kr-matter-tech-card", 1 },
	}
	for _, ingredient in ipairs(params.additional_ingredients or {}) do
		if (data.raw["item"][ingredient]) then
			table.insert(ingredients, ingredient)
		end
	end
	local prerequisites = { "kr-matter-processing" }
	for _, requirement in ipairs(params.additional_requirements or {}) do
		if (data.raw["technology"][requirement]) then
			table.insert(prerequisites, requirement)
		end
	end

	data:extend({
		{
			type = "technology",
			name = assert(params.name),
			icons = make_matter_icon(assert(params.base_icon_path)),
			icon_size = 256,
			order = "g-e-e",
			unit = {
				time = 45,
				count = 1000,
				ingredients = ingredients,
			},
			prerequisites = prerequisites,
			effects = {},
		},
	})
end

return util_matter