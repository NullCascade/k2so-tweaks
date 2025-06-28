
local util_log = {}

function util_log.__call(fmt, ...)
	log(string.format(fmt, ...))
end

return util_log
