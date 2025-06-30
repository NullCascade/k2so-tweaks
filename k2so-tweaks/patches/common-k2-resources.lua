--[[
Problems:
	- Crushing Industries and Moshine have differing opinions on what the "real" sand should be, creating incompatibilities.
	- Additionally, Maraxis has some assumptions about is sand.
Solutions:
	- Brute force all items, recipes, and minables to prefer more open community sand/glass over K2's sand/glass.
	- Changes recipe unlocks to use kr-sand/glass over sand/glass.
	- Make sure k2 glass/sand recipes are available.
	- Changes Nauvis back to being the default planetary exporter of sand/glass.
--]]

local util = require("k2so-tweaks.util")

local patch = util.patch.new_patch("common-k2-resources")

local function replace_k2_item(common_id, k2_id)
	local item = data.raw["item"][common_id]
	if (item == nil) then
		item = table.deepcopy(data.raw["item"][k2_id])
		item.name = common_id
		data:extend({ item })
	end
	util.item.replace_all(k2_id, common_id)
	util.technology.replace_all_unlocks(k2_id, common_id)
	data.raw["recipe"][common_id].hidden = false
	data.raw["recipe"][k2_id].hidden = true
	item.default_import_location = "nauvis"
end

function patch.on_data_final_fixes()
	replace_k2_item("sand", "kr-sand")
	replace_k2_item("glass", "kr-glass")
end

return patch