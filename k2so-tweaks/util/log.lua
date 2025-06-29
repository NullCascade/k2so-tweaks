
local util_log = {}

function util_log:__call(fmt, ...)
	log(string.format(fmt, ...))
end

setmetatable(util_log, util_log)

return util_log
