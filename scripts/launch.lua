
-- define global table before loading main script
mmu = {}

local ret = dofile('scripts/main.lua')
if ret then
	do return ret end
end

-- main window construction
dofile('scripts/window.lua')

local pgGeneral = dofile('scripts/pages/general.lua')
local pgTools = dofile('scripts/pages/tools.lua')

refreshControls()

MainWindow.show()

-- Show any errors/warnings from startup
if #mmu.errors > 0 then
	for idx, msg in pairs(mmu.errors) do
		showMessage(msg)
	end
end
