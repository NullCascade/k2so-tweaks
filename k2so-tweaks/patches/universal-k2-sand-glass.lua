--[[
Problems:
	- Crushing Industries and Moshine have differing opinions on what the "real" sand should be, creating incompatibilities.
	- Additionally, Maraxis has some assumptions about is sand.
Solutions:
	- Brute force all items, recipes, and minables to prefer kr-sand/glass over sand/glass.
	- Changes recipe unlocks to use kr-sand/glass over sand/glass.
	- Make sure k2 glass/sand recipes are available.
	- Changes Nauvis back to being the default planetary exporter of sand/glass.
--]]

local util = require("k2so-tweaks.util")

local patch = util.patch.new_patch("universal-k2-sand-glass")

function patch.on_data_final_fixes()
	local sand = data.raw["item"]["sand"]
	if (sand) then
		util.item.replace_all("sand", "kr-sand")
		util.technology.replace_all_unlocks("sand", "kr-sand")
		data.raw["recipe"]["kr-sand"].hidden = false
		sand.default_import_location = "nauvis"
	end

	local glass = data.raw["item"]["glass"]
	if (glass) then
		util.item.replace_all("glass", "kr-glass")
		util.technology.replace_all_unlocks("glass", "kr-glass")
		data.raw["recipe"]["kr-glass"].hidden = false
		glass.default_import_location = "nauvis"
	end
end

return patch