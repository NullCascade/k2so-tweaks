
local mod_prefix = "nulls-k2so-"

local settings = {
	{
		type = "bool-setting",
		name = mod_prefix .. "expanded-alternate-recipes",
		setting_type = "startup",
		default_value = true,
		order = "1-expanded-alternate-recipes",
	},
	{
		type = "bool-setting",
		name = mod_prefix .. "standardize-stack-sizes",
		setting_type = "startup",
		default_value = true,
		order = "1-standardize-stack-sizes",
	},
	{
		type = "bool-setting",
		name = mod_prefix .. "crushing-industry-ratios",
		setting_type = "startup",
		default_value = true,
		order = "2-crushing-industry-nerf",
	},
}
data:extend(settings)
