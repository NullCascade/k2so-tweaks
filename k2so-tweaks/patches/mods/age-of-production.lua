
local util = require("k2so-tweaks.util")

local patch = util.patch.new_patch("mod-age-of-production")
patch:add_required_mod("Age-of-Production")

function patch.on_data_final_fixes()
	-- K2SO Rifle Ammo
	util.recipe.add_additional_category("kr-armor-piercing-rifle-magazine", "ammunition")
	util.recipe.add_additional_category("kr-imersite-rifle-magazine", "ammunition")
	util.recipe.add_additional_category("kr-rifle-magazine", "ammunition")
	util.recipe.add_additional_category("kr-uranium-rifle-magazine", "ammunition")

	-- K2SO Anti-Materiel Rifle Ammo
	util.recipe.add_additional_category("kr-anti-materiel-rifle-magazine", "ammunition")
	util.recipe.add_additional_category("kr-armor-piercing-anti-materiel-rifle-magazine", "ammunition")
	util.recipe.add_additional_category("kr-imersite-anti-materiel-rifle-magazine", "ammunition")
	util.recipe.add_additional_category("kr-uranium-anti-materiel-rifle-magazine", "ammunition")

	-- K2SO Artillery
	util.recipe.add_additional_category("kr-nuclear-artillery-shell", "ammunition")
	util.recipe.add_additional_category("kr-antimatter-artillery-shell", "ammunition")

	-- K2SO Rockets
	util.recipe.add_additional_category("kr-heavy-rocket", "ammunition")
	util.recipe.add_additional_category("kr-antimatter-rocket", "ammunition")

	-- K2SO Railgun Shells
	util.recipe.add_additional_category("kr-basic-railgun-shell", "ammunition")
	util.recipe.add_additional_category("kr-explosive-railgun-shell", "ammunition")
	util.recipe.add_additional_category("kr-antimatter-railgun-shell", "ammunition")

	-- K2SO Turret Rockets
	util.recipe.add_additional_category("kr-explosive-turret-rocket", "ammunition")
	util.recipe.add_additional_category("kr-nuclear-turret-rocket", "ammunition")
	util.recipe.add_additional_category("kr-antimatter-turret-rocket", "ammunition")

	-- K2SO w/Cerys Ammo
	util.recipe.add_additional_category("plutonium-rounds-magazine", "ammunition")
	util.recipe.add_additional_category("kr-plutonium-rifle-magazine", "ammunition")
	util.recipe.add_additional_category("kr-plutonium-anti-materiel-rifle-magazine", "ammunition")
end

return patch