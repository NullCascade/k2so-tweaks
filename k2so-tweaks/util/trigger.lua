local util_trigger = {}
local util_table = require("k2so-tweaks.util.table")

--- @param effect table
--- @param old_damage number
--- @param new_damage number
--- @param damage_type string
local function update_effect_damage(effect, old_damage, new_damage, damage_type)
	local damage = effect.damage
	if (effect.type == "damage" and damage and damage.type == damage_type and damage.amount == old_damage) then
		damage.amount = new_damage
		return 1
	end

	if (effect.type == "nested-result") then
		util_trigger.update_damage(effect.action, old_damage, new_damage, damage_type)
	end

	return 0
end

--- @param delivery table
--- @param old_damage number
--- @param new_damage number
--- @param damage_type string
local function update_delivery_damage(delivery, old_damage, new_damage, damage_type)
	for _, effect in ipairs(util_table.as_array(delivery.target_effects)) do
		update_effect_damage(effect, old_damage, new_damage, damage_type)
	end
end

--- Updates matching damage effects in a Factorio trigger action.
--- Handles fields that accept either a single definition or an array of definitions.
--- @param action table|nil
--- @param old_damage number
--- @param new_damage number
--- @param damage_type string
function util_trigger.update_damage(action, old_damage, new_damage, damage_type)
	for _, trigger in ipairs(util_table.as_array(action)) do
		for _, delivery in ipairs(util_table.as_array(trigger.action_delivery)) do
			update_delivery_damage(delivery, old_damage, new_damage, damage_type)
		end
	end
end

return util_trigger
