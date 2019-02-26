
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
		dialog.ModalResult = 1
	end

	btnCancel.OnClick = function()
		pName = nil
		dialog.close()
	end

	centerOnMainWindow(dialog)
	dialog.showModal()

	local modalResult = dialog.ModalResult

	dialog.destroy()

	return pName, modalResult
end

--- Creates a dialog to show progress.
local createProgressDialog = function(pName)
	local dialog = createForm(false)
	dialog.setCaption('Open Process')
	dialog.BorderStyle = bsDialog

	dialog.Width = 200
	dialog.Height = 100

	--[[
	dialog.OnClose = function()
		-- '6' is the value returned when mbYes is pressed
		if messageDialog('Are you sure you want to cancel?', mtInformation, mbYes, mbNo) == 6 then
			return dialog.ModalResult
		end
		return dialog.ModalResult
	end
	]]

	local label = createLabel(dialog)
	label.setCaption('Searching for process: ' .. pName)
	label.AnchorSideLeft.Control = dialog
	label.AnchorSideLeft.Side = asrCenter

	local progress = createProgressBar(dialog)
	progress.Anchors = '[akLeft,akRight,akBottom]'
	progress.AnchorSideBottom.Control = dialog
	progress.AnchorSideBottom.Side = asrCenter
	progress.AnchorSideRight.Control = dialog
	progress.AnchorSideRight.Side = asrRight
	progress.setMax(5)

	--[[
	local btnCancel = createButton(dialog)
	btnCancel.setCaption('Cancel')
	btnCancel.Anchors = '[akLeft,akBottom]'
	btnCancel.AnchorSideBottom.Control = dialog
	btnCancel.AnchorSideBottom.Side = asrBottom
	btnCancel.AnchorSideLeft.Control = dialog
	btnCancel.AnchorSideLeft.Side = asrCenter

	btnCancel.OnClick = dialog.close
	]]

	centerOnMainWindow(dialog)

	-- create timer to step progress bar
	local reverse = false
	local timer = createTimer(dialog, false)
	timer.OnTimer = function()
		if reverse then
			progress.setPosition(progress.Position-1)
		else
			progress.setPosition(progress.Position+1)
		end

		if progress.Position == progress.Max then
			reverse = true
		elseif progress.Position == progress.Min then
			reverse = false
		end
	end

	--[[
	dialog.done = function()
		timer.setEnabled(false)
		--dialog.destroy()

		if timer then
			print('Timer not destroyed')
			timer.destroy()
		end

		if timer then
			print('Timer STILL not destroyed')
		else
			print('Timer destroyed')
		end
	end
	]]

	dialog.start = function()
		timer.setEnabled(true)
		dialog.ShowModal()
	end

	dialog.stop = function(finished)
		timer.setEnabled(false)
		dialog.ModalResult = 6
		--[[
		if not finished then
			-- '6' is the value returned when mbYes is pressed
			if messageDialog('Are you sure you want to cancel?', mtInformation, mbYes, mbNo) == 6 then
				dialog.ModalResult = 6
				dialog.done()
			end
		end
		]]

		return dialog.ModalResult
	end

	dialog.pause = function()
		timer.setEnabled(false)
	end

	return dialog
end

-- attaches process
process.attach = function(pName)
	local progress = createProgressDialog(pName)

	local PID = nil

	-- FIXME: open in separate thread
	local thread = createThread(function()
		local wList = getWindowList()

		local proc = nil

		for _, w in pairs(wList) do
			if w.Name == pName then
				proc = w
				break
			end
		end

		progress.pause()

		if proc ~= nil then
			openProcess(proc.PID)
			PID = proc.PID
		else
			showMessage("Process not found: " .. pName)
		end

		progress.stop(true)
	end)

	progress.start()
	progress.destroy()

	return PID
end

return process
