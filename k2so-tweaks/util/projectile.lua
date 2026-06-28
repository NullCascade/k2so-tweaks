local util_projectile = {}
local util_trigger = require("k2so-tweaks.util.trigger")

--- @param projectile_name string
--- @param old_damage number
--- @param new_damage number
--- @param damage_type string
function util_projectile.update_damage(projectile_name, old_damage, new_damage, damage_type)
	local prototype = data.raw["projectile"][projectile_name]
	if (prototype == nil) then
		return
	end

	util_trigger.update_damage(prototype.action, old_damage, new_damage, damage_type)
end

return util_projectile
