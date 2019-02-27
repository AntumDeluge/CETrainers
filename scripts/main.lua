
-- this script must be imported before anything else

if mmu == nil then
	showMessage('ERROR: "mmu" table not defined.')
	do return 1 end
end

mmu.name = 'MMU Trainer'

--- Errors to be shown after window is visible.
mmu.errors = {}

--- Available controls.
mmu.controls = {}

mmu.Record = dofile('scripts/record.lua')
dofile('scripts/functions.lua')
