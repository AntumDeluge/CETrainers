
-- only allow running once instance in same process
if mmu ~= nil then
	showMessage('Trainer is already running')
	do return end
end

-- define global table before loading main script
mmu = {}
mmu.Small = true

-- Function to launch the trainer interface & catch errors.
local startup = function()
	local ret = dofile('scripts/main.lua')
	if ret then
		do return ret end
	end

	dofile('scripts/pages/general.lua')

	mmu.refreshControls()
	mmu.show()
end

local success, err = pcall(startup)
if not success then
	-- free mmu object
	mmu = nil
	-- show error message
	showMessage('ERROR: ' .. err)

	if TrainerOrigin ~= nil then
		-- close CE process
		closeCE()
	end
end
