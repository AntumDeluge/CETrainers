
local record = {}

local addressList = getAddressList()

record.setEnabled = function(r, enabled)
	-- default is enabled
	if enabled == nil then
		enabled = true
	end

	local recType = type(r)
	if recType == "string" then
		r = addressList.getMemoryRecordByDescription(r)
	else
		r = addressList.getMemoryRecord(r)
	end

	r.Active = enabled

	return r.Active
end

return record
