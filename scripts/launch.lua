
dofile('scripts/main.lua')
-- main window construction
dofile('scripts/window.lua')

local pgGeneral = dofile('scripts/pages/general.lua')
local pgEnergy = dofile('scripts/pages/energy.lua')
local pgTools = dofile('scripts/pages/tools.lua')

refreshControls()

MainWindow.show()

-- Show any errors/warnings from startup
if #mmu.errors > 0 then
	for idx, msg in pairs(mmu.errors) do
		showMessage(msg)
	end
end
