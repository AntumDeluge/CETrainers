
--- Function to add startup error/warning message.
mmu.addError = function(msg, label)
	if label == nil then
		label = 'ERROR'
	end
	msg = label .. ': ' .. msg
	table.insert(mmu.errors, msg)
end

--- Alias for mmu.addError(msg, 'WARNING')
mmu.addWarning = function(msg)
	mmu.addError(msg, 'WARNING')
end

-- usable control types
local control_types = {
	-- a 'check' simply enables/disables a memory record
	check = {'check', 'chck', 'chk',},
	-- a 'checkvalue' manipulates the value of the record instead of its enabled state
	'checkvalue',
}

function refreshControls()
	local pAttached = getOpenedProcessID() ~= 0
	for _, ctrl in pairs(mmu.controls) do
		if not pAttached then
			ctrl.Control.setEnabled(false)
		elseif ctrl.Record.Type ~= 11 then -- 11 = script?
			ctrl.Control.setEnabled(ctrl.Record.IsReadable)
		else
			ctrl.Control.setEnabled(true)
			ctrl.Control.Checked = ctrl.Record.Active
		end
	end
end

local function createCheckControl(ctrl, parent)
	ctrl.Control = createCheckBox(parent)

	-- function to check if check box & record states are the same
	ctrl.synchronized = function()
		return ctrl.Control.Checked == ctrl.Record.Active
	end

	ctrl.Control.OnChange = function(sender)
		if not ctrl.synchronized() then
			if sender == ctrl.Control then
				ctrl.Record.Active = ctrl.Control.Checked
			elseif sender == ctrl.Record then
				ctrl.Control.Checked = ctrl.Record.Active
			end
		end

		if not ctrl.synchronized() then
			showMessage('An error occurred trying to set state of "' .. ctrl.Record.Description .. '"')
			-- reset state
			ctrl.Control.Checked = not ctrl.Control.Checked
		end
	end
	-- TODO: listen for changes from main Cheat Engine process
end

local function createCheckValueControl(ctrl, parent)
	ctrl.Control = createCheckBox(parent)

	-- function to check if check box & record value in sync
	ctrl.synchronized = function()
		return (not ctrl.Control.Checked and ctrl.Record.Value == '0') or (ctrl.Control.Checked and ctrl.Record.Value ~= '0')
	end

	ctrl.Control.OnChange = function(sender)
		print('Record: ' .. ctrl.Record.Description)
		if not ctrl.synchronized() then
			print('Changing ...')
			if sender == ctrl.Control then
				if ctrl.Control.Checked then
					ctrl.Record.Value = '1'
				else
					ctrl.Record.Value = '0'
				end
			elseif sender == ctrl.Record then
				ctrl.Control.Checked = ctrl.Record.Value ~= '0'
			end
		end
	end

	-- polls record value to catch changes
	local prevValue = ctrl.Record.Value
	ctrl.Record.OnGetDisplayValue = function(sender, curValue)
		local changed = prevValue and (prevValue ~= curValue)
		prevValue = curValue

		if changed then
			ctrl.Control.OnChange(rec)
		end

		return false, curValue
	end
end

--- Function to create a control based on control types.
--
-- @function createControl
-- @tparam string ctrltype
-- @param rec
-- @tparam WinControl parent
function createControl(ctrltype, rec, parent)
	local sibling_count = parent.ControlCount

	local ctrl = {}

	if rec ~= nil and type(rec) ~= 'userdata' then
		ctrl.Record = record.get(rec)
	else
		ctrl.Record = rec
	end

	-- check for valid control type
	local validControl = false
	for idx, c1 in pairs(control_types) do
		if type(c1) == 'table' then
			for _, c2 in pairs(c1) do
				if ctrltype == c2 then
					validControl = true
					-- set control type to first index value
					ctrltype = c1[1]
					break
				end
			end
		elseif ctrltype == c1 then
			validControl = true
		end

		if validControl then break end
	end

	if not validControl then
		mmu.addWarning('Cannot create control type: ' .. ctrltype)
	else
		-- control creation
		if ctrltype == 'check' then
			createCheckControl(ctrl, parent)
		elseif ctrltype == 'checkvalue' then
			createCheckValueControl(ctrl, parent)
		end

		if ctrl.Control ~= nil then
			ctrl.Control.setCaption(ctrl.Record.Description)

			-- anchor new control to sibling
			if sibling_count > 0 then
				ctrl.Control.AnchorSideTop.Control = parent.getControl(sibling_count - 1)
				ctrl.Control.AnchorSideTop.Side = asrBottom
			end

			-- add to list of accessible controls
			table.insert(mmu.controls, ctrl)
		end
	end

	return ctrl
end

--- Function to center a sub-window on the main Form
--
-- @function centerOnMainWindow
-- @tparam Form form
function centerOnMainWindow(form)
	--local mw = getMainForm()
	local x = MainWindow.Left + (MainWindow.Width - form.Width) / 2
	local y = MainWindow.Top + (MainWindow.Height - form.Height) / 2

	form.setPosition(x, y)
end
