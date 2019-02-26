
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

--- Function to create a control based on control types.
--
-- @function createControl
-- @tparam string ctrltype
-- @param rec
-- @tparam WinControl parent
function createControl(ctrltype, rec, parent)
	-- create a table for keeping track of child objects
	if parent.Children == nil then
		parent.Children = {}
	end

	local sibling_count = #parent.Children

	local control = {}

	if rec ~=nil and type(rec) ~= 'userdata' then
		control.Record = record.get(rec)
	else
		control.Record = rec
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
		if ctrltype == 'check' then
			control.Control = createCheckBox(parent)
		end

		if control.Control ~= nil then
			control.Control.setCaption(control.Record.Description)

			-- add successfully created child to 'Children' table
			table.insert(parent.Children, control.Control)

			-- anchor new control to sibling
			if sibling_count > 0 then
				control.Control.AnchorSideTop.Control = parent.Children[sibling_count]
				control.Control.AnchorSideTop.Side = asrBottom
			end
		end
	end

	return control
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
