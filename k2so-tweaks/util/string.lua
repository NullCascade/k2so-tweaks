local util_string = {}

--- Determines if one string starts with another
--- @param str string
--- @param needle string
function util_string.starts_with(str, needle)
	return string.sub(str, 1, string.len(needle)) == needle
end

return util_string

