
local util = require("k2so-tweaks.util")

local patch = util.patch.new_patch("planet-maraxsis")
patch:add_required_mod("maraxsis")

local function copy_buildability_rules(type, from, to)
	local prototype_from = data.raw[type][from]
	local prototype_to = data.raw[type][to]
	if (not prototype_from) then
		util.log("Could copy maraxsis compatibility from %s: Prototype does not exist.", from, to)
		return
	elseif (not prototype_to) then
		util.log("Could copy maraxsis compatibility to %s: Prototype does not exist.", from, to)
		return
	end

	-- Clone buildability rules.
	prototype_to.maraxsis_buildability_rules = prototype_from.maraxsis_buildability_rules

	-- Clone mod data.
	local maraxsis_constants = data.raw["mod-data"]["maraxsis-constants"]
	if (maraxsis_constants) then
		-- Determines if a building is excluded from the buildability rules.
		-- Allows it to be built outside of/only in pressurized domes.
		local excluded_buildings = maraxsis_constants.data["DOME_EXCLUDED_FROM_DISABLE"] or {} --[[@as table<string, boolean>]]
		excluded_buildings[to] = excluded_buildings[from]
	end
end

function patch.on_data()
	-- Allow certain other buildings to function in water.
	copy_buildability_rules("assembling-machine", "chemical-plant", "kr-advanced-chemical-plant")

	-- Update constants to point to the standard sand ID.
	local maraxis_constants = data.raw["mod-data"]["maraxsis-constants"]
	if (maraxis_constants) then
		maraxis_constants.SAND_ITEM_NAME = "sand" --- @diagnostic disable-line
	end
end

function patch.on_data_final_fixes()
	-- Atmosphere is obtained using atmosphere condensation
	-- TODO: The atmosphere condensation machine can't be placed in a way that is compatible with this. Figure it out later.
	util.recipe.add_additional_category("maraxsis-atmosphere", "kr-atmosphere-condensation")
end

return patch