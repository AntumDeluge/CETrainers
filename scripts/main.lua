
-- main table
mmu = {}
mmu.name = 'MMU Trainer'

-- run as standalone executable
local standalone = TrainerOrigin ~= nil

--- Errors to be shown after window is visible.
mmu.errors = {}
mmu.addError = function(msg, label)
	if label == nil then
		label = 'ERROR'
	end
	msg = label .. ': ' .. msg
	table.insert(mmu.errors, msg)
end
mmu.addWarning = function(msg)
	mmu.addError(msg, 'WARNING')
end

-- create main window but do not show it yet
MainWindow = createForm(false)
MainWindow.BorderStyle = bsSizeable

-- set minimum size
MainWindow.Constraints.MinWidth = 320
MainWindow.Constraints.MinHeight = 350

-- icon displayed in the main interface
local icon = createPicture()
icon.loadFromFile('data/bitmap/icon.png')
MainWindow.Icon = icon.getBitmap()


-- closes trainer
local function shutdown()
	-- free memory allocated for the main interface
	MainWindow.destroy()

	-- trainer is run as a standalone executable
	if standalone then
		-- shuts down the main CE process
		closeCE()
		return caFree
	end
end

-- text displayed in title bar
MainWindow.setCaption(mmu.name)

dofile('scripts/menu.lua')

-- action to take when 'X-ed' out of
MainWindow.onClose = shutdown

mmu.processLabel = createLabel(MainWindow)
mmu.processLabel.anchorSideLeft.control = MainWindow
mmu.processLabel.anchorSideLeft.side = asrCenter

local loadedProcess = getOpenedProcessID()
if loadedProcess > 0 then
	mmu.processLabel.setCaption('Attached process: ' .. tostring(loadedProcess))
else
	mmu.processLabel.setCaption('Attached process:')
end

record = dofile('scripts/record.lua')

-- make main window visible
MainWindow.ShowInTaskBar = 'stAlways'
MainWindow.centerScreen()
