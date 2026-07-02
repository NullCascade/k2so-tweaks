local util_assembler = {}
local util_log = require("k2so-tweaks.util.log")
local util_table = require("k2so-tweaks.util.table")

--- @param machine_name string
--- @param category string
--- @return boolean added
function util_assembler.add_crafting_category(machine_name, category)
	local machine = data.raw["assembling-machine"][machine_name]
	if (not machine) then
		return false
	end

	machine.crafting_categories = machine.crafting_categories or {}
	return util_table.insert_unique(machine.crafting_categories, category)
end

--- @param machine_name string
--- @param category string
--- @return boolean removed
function util_assembler.remove_crafting_category(machine_name, category)
	local machine = data.raw["assembling-machine"][machine_name]
	if (not machine or not machine.crafting_categories) then
		return false
	end

	return util_table.remove_value(machine.crafting_categories, category)
end

--- @param from string
--- @param to string
function util_assembler.copy_crafting_categories(from, to)
	local from_prototype = data.raw["assembling-machine"][from]
	local to_prototype = data.raw["assembling-machine"][to]
	if (not from_prototype or not to_prototype) then
		return
	end

	for _, category in ipairs(from_prototype.crafting_categories or {}) do
		util_assembler.add_crafting_category(to, category)
	end
end

return util_assembler
