local util_surface = {}

--- @param surface data.PlanetPrototype
--- @param property string
--- @return data.SurfaceCondition?
function util_surface.create_exact_surface_condition(surface, property)
	local surface_properties = surface.surface_properties or {}
	local value = surface_properties[property]
	if (value == nil) then
		return nil
	end

	return {
		property = property,
		min = value,
		max = value,
	}
end

--- @param surface data.PlanetPrototype|data.SurfacePrototype
--- @param property string
--- @return number?
function util_surface.get_property_value(surface, property)
	local surface_properties = surface.surface_properties or {}
	local value = surface_properties[property]
	if (value ~= nil) then
		return value
	end

	-- Fall back to default value.
	local surface_property = data.raw["surface-property"] and data.raw["surface-property"][property]
	if (surface_property == nil) then
		return nil
	end

	return surface_property.default_value
end

--- @return string[]
local function get_surface_property_names()
	local names = {}
	local seen = {}

	for property, _ in pairs(data.raw["surface-property"] or {}) do
		table.insert(names, property)
		seen[property] = true
	end

	for _, surface_type in ipairs({ "planet", "surface" }) do
		for _, surface in pairs(data.raw[surface_type] or {}) do
			for property, _ in pairs(surface.surface_properties or {}) do
				if (not seen[property]) then
					table.insert(names, property)
					seen[property] = true
				end
			end
		end
	end

	table.sort(names)
	return names
end

--- @param surface string|data.PlanetPrototype|data.SurfacePrototype
--- @return data.PlanetPrototype|data.SurfacePrototype|nil
local function resolve_surface(surface)
	if (type(surface) ~= "string") then
		return surface
	end

	return (data.raw["planet"] and data.raw["planet"][surface])
		or (data.raw["surface"] and data.raw["surface"][surface])
end

--- @param surfaces (data.PlanetPrototype|data.SurfacePrototype)[]
--- @param properties string[]
--- @return data.SurfaceCondition[]
local function create_tight_surface_conditions(surfaces, properties)
	local conditions = {}

	for _, property in ipairs(properties) do
		local min = nil
		local max = nil
		local has_all_values = true

		for _, surface in ipairs(surfaces) do
			local value = util_surface.get_property_value(surface, property)
			if (value == nil) then
				has_all_values = false
				break
			end

			if (min == nil or value < min) then
				min = value
			end
			if (max == nil or value > max) then
				max = value
			end
		end

		if (has_all_values and min ~= nil and max ~= nil) then
			table.insert(conditions, {
				property = property,
				min = min,
				max = max,
			})
		end
	end

	return conditions
end

--- @param surface data.PlanetPrototype|data.SurfacePrototype
--- @param conditions data.SurfaceCondition[]
--- @return boolean
local function surface_matches_conditions(surface, conditions)
	for _, condition in ipairs(conditions) do
		local value = util_surface.get_property_value(surface, condition.property)
		if (value == nil) then
			return false
		end
		if (condition.min ~= nil and value < condition.min) then
			return false
		end
		if (condition.max ~= nil and value > condition.max) then
			return false
		end
	end

	return true
end

--- @return (data.PlanetPrototype|data.SurfacePrototype)[]
local function get_all_surfaces()
	local surfaces = {}

	for _, surface_type in ipairs({ "planet", "surface" }) do
		for _, surface in pairs(data.raw[surface_type] or {}) do
			table.insert(surfaces, surface)
		end
	end

	return surfaces
end

--- @param a data.SurfaceCondition
--- @param b data.SurfaceCondition
--- @return boolean
local function compare_surface_conditions(a, b)
	return a.property < b.property
end

--- @param surfaces (data.PlanetPrototype|data.SurfacePrototype)[]
--- @return string[]
local function get_surface_names(surfaces)
	local names = {}
	for _, surface in ipairs(surfaces) do
		table.insert(names, surface.name)
	end
	table.sort(names)
	return names
end

--- @param conditions data.SurfaceCondition[]
--- @param excluded_surfaces (data.PlanetPrototype|data.SurfacePrototype)[]
--- @return data.SurfaceCondition[]
local function keep_required_conditions(conditions, excluded_surfaces)
	local kept_conditions = {}
	local uncovered_surface_names = {}

	for _, surface in ipairs(excluded_surfaces) do
		uncovered_surface_names[surface.name] = true
	end

	while (next(uncovered_surface_names) ~= nil) do
		local best_condition = nil
		local best_excluded_names = {}
		local best_count = 0

		for _, condition in ipairs(conditions) do
			local excluded_names = {}
			local count = 0

			for _, surface in ipairs(excluded_surfaces) do
				if (uncovered_surface_names[surface.name] and not surface_matches_conditions(surface, { condition })) then
					table.insert(excluded_names, surface.name)
					count = count + 1
				end
			end

			if (count > best_count) then
				best_condition = condition
				best_excluded_names = excluded_names
				best_count = count
			end
		end

		if (best_condition == nil) then
			return {}
		end

		table.insert(kept_conditions, best_condition)
		for _, surface_name in ipairs(best_excluded_names) do
			uncovered_surface_names[surface_name] = nil
		end
	end

	table.sort(kept_conditions, compare_surface_conditions)

	return kept_conditions
end

--- @param prototype table
--- @param surfaces (string|data.PlanetPrototype|data.SurfacePrototype)[]
--- @return data.SurfaceCondition[]?
function util_surface.restrict_to_surfaces(prototype, surfaces)
	local util = require("k2so-tweaks.util")

	if (prototype == nil) then
		util.log("Cannot restrict nil prototype to surfaces.")
		return nil
	end

	local allowed_surfaces = {}
	local allowed_surface_names = {}

	for _, surface in ipairs(surfaces or {}) do
		local resolved_surface = resolve_surface(surface)
		if (resolved_surface == nil) then
			util.log("Surface '%s' does not exist.", surface)
			return nil
		end
		if (resolved_surface.name == nil) then
			util.log("Surface prototype is missing a name.")
			return nil
		end
		if (not allowed_surface_names[resolved_surface.name]) then
			table.insert(allowed_surfaces, resolved_surface)
			allowed_surface_names[resolved_surface.name] = true
		end
	end

	if (#allowed_surfaces == 0) then
		util.log("Cannot restrict '%s' to an empty surface set.", prototype.name or "<unnamed>")
		return nil
	end

	local conditions = create_tight_surface_conditions(allowed_surfaces, get_surface_property_names())
	local excluded_surfaces = {}

	for _, surface in ipairs(get_all_surfaces()) do
		local is_allowed = allowed_surface_names[surface.name] == true
		local matches_conditions = surface_matches_conditions(surface, conditions)

		if (is_allowed and not matches_conditions) then
			util.log("Calculated surface conditions for '%s' exclude allowed surface '%s'.", prototype.name or "<unnamed>", surface.name)
			return nil
		end
		if (not is_allowed and matches_conditions) then
			util.log("Cannot restrict '%s' to only '%s'; surface '%s' also matches the calculated conditions.", prototype.name or "<unnamed>", table.concat(get_surface_names(allowed_surfaces), ", "), surface.name)
			return nil
		end
		if (not is_allowed) then
			table.insert(excluded_surfaces, surface)
		end
	end

	prototype.surface_conditions = keep_required_conditions(conditions, excluded_surfaces)
	return prototype.surface_conditions
end

--- @param entity_type string
--- @param entity_id string
--- @param planet_id string
function util_surface.relax_conditions_for_planet(entity_type, entity_id, planet_id)
	local util = require("k2so-tweaks.util")

	local surface = data.raw["planet"][planet_id]
	if (surface == nil) then
		util.log("Planet '%s' does not exist.", planet_id)
		return
	end

	local prototype = data.raw[entity_type][entity_id]
	if (prototype == nil) then
		util.log("Entity '%s' of type '%s' does not exist.", entity_id, entity_type)
		return nil
	end

	local surface_properties = surface.surface_properties or {}
	for _, condition in ipairs(prototype.surface_conditions or {}) do
		local surface_condition = surface_properties[condition.property]
		if (surface_condition) then
			if (condition.min > surface_condition) then
				condition.min = surface_condition
			end
			if (condition.max < surface_condition) then
				condition.max = surface_condition
			end
		end
	end
end

--- @param entity_type string
--- @param entity_id string
--- @param condition string
--- @param min number?
--- @param max number?
function util_surface.enforce_condition(entity_type, entity_id, condition, min, max)
	local util = require("k2so-tweaks.util")

	local prototype = data.raw[entity_type][entity_id]
	if (prototype == nil) then
		util.log("Entity '%s' of type '%s' does not exist.", entity_id, entity_type)
		return nil
	end

	prototype.surface_conditions = prototype.surface_conditions or {}
	local surface_condition = util.table.find_keyvalues(prototype.surface_conditions, { property = condition }) --[[@as data.SurfaceCondition]]
	if (surface_condition == nil) then
		surface_condition = { property = condition, min = min, max = max }
		table.insert(prototype.surface_conditions, surface_condition)
		return
	end

	surface_condition.min = math.min(surface_condition.min, min)
	surface_condition.max = math.max(surface_condition.max, max)
end

--- @param planet_id string
--- @return number?
function util_surface.get_pollutant_type(planet_id)
	local surface = data.raw["planet"][planet_id]
	if (not surface) then
		return nil
	end

	local surface_properties = surface.surface_properties
	if (not surface_properties) then
		return nil
	end

	return surface_properties["pollutant-type"]
end

return util_surface