
if mmu.small then
	mmu.name = 'Minimalist ' .. mmu.name
end

-- run as standalone executable
local standalone = TrainerOrigin ~= nil

-- create main window but do not show it yet
mmu.Frame = createForm(false)
mmu.Frame.BorderStyle = bsSizeable

-- set minimum size
mmu.Frame.Constraints.MinWidth = 320
mmu.Frame.Constraints.MinHeight = 350

-- icon displayed in the main interface
local icon = createPicture()
icon.loadFromFile('data/bitmap/icon.png')
mmu.Frame.Icon = icon.getBitmap()


-- closes trainer
local function shutdown()
	-- free memory allocated for the main interface
	mmu.Frame.destroy()
	-- free memory allocated to main global table
	mmu = nil

	-- trainer is run as a standalone executable
	if standalone then
		-- shuts down the main CE process
		closeCE()
		return caFree
	end
end

-- text displayed in title bar
mmu.Frame.setCaption(mmu.name)

dofile('scripts/menu.lua')

-- action to take when 'X-ed' out of
mmu.Frame.onClose = shutdown

mmu.processLabel = createLabel(mmu.Frame)
mmu.processLabel.anchorSideLeft.control = mmu.Frame
mmu.processLabel.anchorSideLeft.side = asrCenter

local loadedProcess = getOpenedProcessID()
if loadedProcess > 0 then
	mmu.processLabel.setCaption('Attached process: ' .. tostring(loadedProcess))
else
	mmu.processLabel.setCaption('Attached process:')
end

-- tabbed interface (single panel for minimalist trainer)
tabs = dofile('scripts/tabs.lua')

-- make main window visible
mmu.Frame.ShowInTaskBar = 'stAlways'
mmu.Frame.centerScreen()

-- override show method to display error messages
local showOrig = mmu.Frame.show
mmu.Frame.show = function()
	showOrig()

	-- Show any errors/warnings from startup
	if #mmu.errors > 0 then
		for idx, msg in pairs(mmu.errors) do
			showMessage(msg)
		end
	end
end
