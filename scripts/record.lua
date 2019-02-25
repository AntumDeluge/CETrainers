
local record = {}

local addressList = getAddressList()

record.get = function(r, byid)
	local recInput = r
	local recType = type(r)
	if recType == "string" then
		r = addressList.getMemoryRecordByDescription(r)
	else
		if byid then
			r = addressList.getMemoryRecordByID(r)
		else
			r = addressList.getMemoryRecord(r)
		end
	end

	if r == nil then
		mmu.addWarning('Record not found: ' .. tostring(recInput))
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
