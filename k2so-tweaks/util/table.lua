local util_table = {}

--- Clears all data from a table.
--- @param t table
function util_table.clear(t)
	for k, _ in pairs(t) do
		t[k] = nil
	end
end

--- Determines if a table contains a given value.
--- @param t table The table to search.
--- @param value any The value to search for.
--- @return boolean contained Set if the value is contained in the given table.
function util_table.contains(t, value)
	return util_table.find(t, value) ~= nil
end

--- Returns the first (arbitrary) key for a given value.
--- @param t table The table to search.
--- @param value any The value to search for.
--- @return any key key associated with the given value.
function util_table.find(t, value)
	for i, v in pairs(t) do
		if (v == value) then
			return i
		end
	end
end

--- Removes the first (arbitrary) instance of a value in a given table.
--- @param t table The table to modify.
--- @param value any The value to remove.
--- @return boolean success True if the value was successfully removed.
function util_table.remove_value(t, value)
	local i = util_table.find(t, value)
	if (i ~= nil) then
		table.remove(t, i)
		return true
	end
	return false
end

return util_table

