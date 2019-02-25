
local process = {}

-- retrieves a list of running processes
local getWindowList = function()
	local wList = {}
	local names = createStringList()
	getProcessList(names)

	for i=0, names.getCount()-1 do
		local tmp = names.getString(i)
		local N = tmp:sub(10,255)
		local ID = tonumber("0x" .. tmp:sub(1,8))

		local added = false
		for _, p in pairs(wList) do
			if p.Name == N then
				added = true
				break
			end
		end

		if not added then
			-- get info about the process
			for _, m in pairs(enumModules(ID)) do
				-- only include processes using GUI libraries
				-- FIXME: not cross-platform
				if string.lower(m.Name) == "shell32.dll" then
					wList[i] = {
						Name = N,
						PID = ID,
						}
					break
				end
			end
		end
	end

	return wList
end

-- attaches process
process.attach = function()
	local pName = "MMU.exe"
	local wList = getWindowList()

	local process = nil

	for _, w in pairs(wList) do
		if w.Name == pName then
			process = w
			break
		end
	end

	if process ~= nil then
		openProcess(process.PID)
		return process.PID
	else
		-- TODO: allow process to be attached manually
		showMessage("Process not found: " .. pName)
	end
end

return process
