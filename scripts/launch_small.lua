
-- only allow running once instance in same process
if mmu ~= nil then
	showMessage('Trainer is already running')
	do return end
end

-- define global table before loading main script
mmu = {}
mmu.small = true

local ret = dofile('scripts/main.lua')
if ret then
	do return ret end
end

-- main window construction
dofile('scripts/window.lua')

-- record controls
local instantDeath = createControl('check', 'Instant Death', tabs)
local autoEndStage = createControl('check', 'Auto End Stage', tabs)

refreshControls()

MainWindow.show()
