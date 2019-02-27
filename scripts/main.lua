
-- this script must be imported before anything else

if mmu == nil then
	showMessage('ERROR: "mmu" table not defined.')
	do return 1 end
end

mmu.name = 'MMU Trainer'
if mmu.small then
	mmu.name = 'Minimalist ' .. mmu.name
end

--- Errors to be shown after window is visible.
mmu.errors = {}

--- Available controls.
mmu.controls = {}

mmu.Record = dofile('scripts/record.lua')
dofile('scripts/functions.lua')

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

-- text displayed in title bar
mmu.Frame.setCaption(mmu.name)

dofile('scripts/menu.lua')

-- action to take when 'X-ed' out of
mmu.Frame.onClose = mmu.shutdown

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
