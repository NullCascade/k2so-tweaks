
local util = require("k2so-tweaks.util")

local patch = util.patch.new_patch("mod-age-of-production")
patch:add_required_mod("Age-of-Production")

local function copy_crafting_categories(from, to)
	local from_prototype = data.raw["assembling-machine"][from]
	local to_prototype = data.raw["assembling-machine"][to]
	if (not from_prototype or not to_prototype) then
		return
	end

	for _, category in ipairs(from_prototype.crafting_categories) do
		if (util.table.insert_unique(to_prototype.crafting_categories, category)) then
			util.log("Added category '%s' to assembling machine '%s'", category, to)
		end
	end
end

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

	-- Fixup K2's crafting machines to work with AoP's categories.
	copy_crafting_categories("assembling-machine-3", "kr-advanced-assembling-machine")
	copy_crafting_categories("chemical-plant", "kr-advanced-chemical-plant")
	copy_crafting_categories("foundry", "kr-advanced-furnace")
end

return patch