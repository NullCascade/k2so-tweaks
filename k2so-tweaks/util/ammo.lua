local util_ammo = {}
local util_trigger = require("k2so-tweaks.util.trigger")

--- @param ammo_name string
--- @param new_size number
function util_ammo.set_magazine_size(ammo_name, new_size)
	local prototype = data.raw["ammo"][ammo_name]
	if (prototype == nil) then
		return
	end

	prototype.magazine_size = new_size
end

--- @param ammo_name string
--- @param old_damage number
--- @param new_damage number
--- @param damage_type string
function util_ammo.update_damage(ammo_name, old_damage, new_damage, damage_type)
	local prototype = data.raw["ammo"][ammo_name]
	if (prototype == nil) then
		return
	end

	local ammo_type = prototype.ammo_type
	local ammo_action = ammo_type and ammo_type.action
	if (ammo_action == nil) then
		return
	end

	util_trigger.update_damage(ammo_action, old_damage, new_damage, damage_type)
end

return util_ammo