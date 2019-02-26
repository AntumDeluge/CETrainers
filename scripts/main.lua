
-- this script must be imported before anything else

-- main table
mmu = {}
mmu.name = 'MMU Trainer'

--- Errors to be shown after window is visible.
mmu.errors = {}

--- Available controls.
mmu.controls = {}

record = dofile('scripts/record.lua')
dofile('scripts/functions.lua')
