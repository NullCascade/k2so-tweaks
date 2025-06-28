local util_patch = {}

local patch_install_order = {}
local patches = {}

local patch_metatable = {}

patch_metatable.__index = patch_metatable

function patch_metatable:add_requirement(required_condition_function)
	table.insert(self.requirements, required_condition_function)
end

function patch_metatable:add_required_mod(mod_id)
	self:add_requirement(function() return mods[mod_id] ~= nil end)
end

function patch_metatable:add_required_startup_setting_equal(key, value)
	self:add_requirement(function()
		local var = settings.startup[key]
		if (var == nil) then
			log(string.format("Setting '%s' does not exist.", key))
			return false
		end
		if (var.value ~= value) then
			log(string.format("Setting '%s' (%s) does not equal '%s'.", key, var.value, value))
		end
		return var.value == value
	end)
end

function patch_metatable:check_requirements()
	for _, requirement in ipairs(self.requirements) do
		if not requirement() then
			return false
		end
	end
	return true
end

function util_patch.new_patch(name)
	local patch = {
		name = name,
		requirements = {},
	}

	local patch = setmetatable(patch, patch_metatable)
	patches[name] = patch
	table.insert(patch_install_order, patch)

	return patch
end

function util_patch.do_data()
	local util = require("k2so-tweaks.util")
	for _, patch in ipairs(patch_install_order) do
		if (patch.on_data == nil) then
			util.log("WARNING: Patch '%s' is instanced during phase 'data' but does not have a valid callback. It can be removed from data.lua.")
		end

		if (patch.on_data and patch:check_requirements()) then
			patch.on_data()
		end
	end
end

function util_patch.do_data_updates()
	local util = require("k2so-tweaks.util")
	for _, patch in ipairs(patch_install_order) do
		if (patch.on_data_updates == nil) then
			util.log("WARNING: Patch '%s' is instanced during phase 'data_updates' but does not have a valid callback. It can be removed from data-updates.lua.")
		end

		if (patch.on_data_updates and patch:check_requirements()) then
			patch.on_data_updates()
		end
	end
end

function util_patch.do_data_final_fixes()
	local util = require("k2so-tweaks.util")
	for _, patch in ipairs(patch_install_order) do
		if (patch.on_data_final_fixes == nil) then
			util.log("WARNING: Patch '%s' is instanced during phase 'data_final_fixes' but does not have a valid callback. It can be removed from data-updates.lua.")
		end

		if (patch.on_data_final_fixes and patch:check_requirements()) then
			patch.on_data_final_fixes()
		end
	end
end

return util_patch