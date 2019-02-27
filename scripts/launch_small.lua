
-- only allow running once instance in same process
if mmu ~= nil then
	showMessage('Trainer is already running')
	do return end
end

-- define global table before loading main script
mmu = {}
mmu.small = true

-- Function to launch the trainer interface & catch errors.
local startup = function()
	local ret = dofile('scripts/main.lua')
	if ret then
		do return ret end
	end

	-- record controls
	local instantDeath = mmu.createControl('check', 'Instant Death', tabs)
	local autoEndStage = mmu.createControl('check', 'Auto End Stage', tabs)

	mmu.refreshControls()
	mmu.show()
end

local success, err = pcall(startup)
if not success then
	-- free mmu object
	mmu = nil
	-- show error message
	showMessage('ERROR: ' .. err)
end
