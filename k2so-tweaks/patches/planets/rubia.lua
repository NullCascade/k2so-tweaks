local util = require("k2so-tweaks.util")

local patch = util.patch.new_patch("planet-rubia")
patch:add_required_mod("rubia")

local function change_projectile_damage_type(name, from_type, to_type)
	if (not data.raw["damage-type"][to_type]) then
		return
	end

	local prototype = data.raw["projectile"][name]
	if (not prototype) then
		return
	end

	local effects = prototype.action.action_delivery.target_effects
	for _, effect in ipairs(effects or {}) do
		if (effect.type == "damage" and effect.damage.type == "physical") then
			effect.damage.type = to_type
		end
	end
end

function patch.on_data_final_fixes()
	-- Make K2's railguns also have the kinetic damage type Rubia implements.
	local railgun_projectiles = { "kr-basic-railgun-projectile", "kr-explosion-railgun-projectile", "kr-matter-railgun-projectile" }
	for _, name in ipairs(railgun_projectiles) do
		change_projectile_damage_type(name, "physical", "rubia-kinetic")
	end
end

return patch