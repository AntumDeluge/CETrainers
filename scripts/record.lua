
local record = {}

local addressList = getAddressList()

record.get = function(r)
	local recType = type(r)
	if recType == "string" then
		r = addressList.getMemoryRecordByDescription(r)
	else
		r = addressList.getMemoryRecord(r)
	end

	return r
end

record.setEnabled = function(r, enabled)
	-- default is enabled
	if enabled == nil then
		enabled = true
	end

	r = record.get(r)
	r.Active = enabled

	return r.Active
end

return record
