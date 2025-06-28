
local mod_prefix = "nulls-k2so-"

local settings = {
	{
		type = "bool-setting",
		name = mod_prefix .. "crushing-industry-ratios",
		setting_type = "startup",
		default_value = true,
		order = "crushing-industry-nerf",
	},
}
data:extend(settings)
