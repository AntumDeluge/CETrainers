
local process = {}
local pNameDefault = 'MMU.exe'

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

--- Checks if process is running.
--
-- @function process.find
-- @tparam WinControl parent The parent window for the dialog
process.setName = function(pName)
	pName = pName or pNameDefault

	local dialog = createForm(false)
	dialog.BorderStyle = bsDialog
	dialog.setCaption('Open a process...')
	dialog.Width = 200
	dialog.Height = 100

	local label = createLabel(dialog)
	label.setCaption('Process name (default=' .. pNameDefault .. '):')
	label.AnchorSideLeft.Control = dialog
	label.AnchorSideLeft.Side = asrCenter
	local input = createEdit(dialog)
	-- TODO: add some padding to left & right of input
	input.Text = pName
	input.Anchors = '[akTop,akLeft,akRight]'
	input.AnchorSideTop.Control = label
	input.AnchorSideTop.Side = asrBottom
	input.AnchorSideRight.Control = dialog
	input.AnchorSideRight.side = asrRight

	-- OK/cancel buttons
	local btnAccept = createButton(dialog)
	btnAccept.setCaption('OK')
	local btnCancel = createButton(dialog)
	btnCancel.setCaption('Cancel')
	for _, btn in pairs({btnAccept, btnCancel,}) do
		btn.Anchors = '[akRight,akBottom]'
		btn.AnchorSideBottom.Control = dialog
		btn.AnchorSideBottom.Side = asrBottom
	end
	btnAccept.AnchorSideRight.Control = dialog
	btnAccept.AnchorSideRight.Side = asrRight
	btnCancel.AnchorSideRight.Control = btnAccept
	btnCancel.AnchorSideRight.Side = asrLeft

	local getValue = function()
		-- remove leading & trailing whitespace
		return input.Text:gsub("^%s*(.-)%s*$", "%1")
	end

	local isEmpty = function()
		return getValue() == ''
	end

	btnAccept.OnClick = function()
		if isEmpty() then
			showMessage('Process name cannot be empty')
			-- reset input text in case of whitespace
			input.Text = ''
			return
		end

		pName = getValue()
		dialog.close()
	end

	btnCancel.OnClick = function()
		pName = nil
		dialog.close()
	end

	centerOnMainWindow(dialog)
	dialog.showModal()
	dialog.destroy()

	return pName
end

-- attaches process
process.attach = function(pName)
	local wList = getWindowList()

	local proc = nil

	for _, w in pairs(wList) do
		if w.Name == pName then
			proc = w
			break
		end
	end

	if proc ~= nil then
		openProcess(proc.PID)
		return proc.PID
	else
		showMessage('Process not found: ' .. pName)
	end
end

return process
