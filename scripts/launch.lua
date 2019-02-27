
-- only allow running once instance in same process
if mmu ~= nil then
	showMessage('Trainer is already running')
	do return end
end

-- define global table before loading main script
mmu = {}

local ret = dofile('scripts/main.lua')
if ret then
	do return ret end
end

local pgGeneral = dofile('scripts/pages/general.lua')
local pgTools = dofile('scripts/pages/tools.lua')

mmu.refreshControls()

mmu.show()
