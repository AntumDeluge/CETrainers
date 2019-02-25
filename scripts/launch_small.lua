
dofile('scripts/main.lua')

mmu.small = true

-- main window construction
dofile('scripts/window.lua')

-- record controls
local instantDeath = createControl('check', 'Instant Death', tabs)
local autoEndStage = createControl('chk', 'Auto End Stage', tabs)
local invincibility = createControl('chks', 'Invincibility', tabs)

MainWindow.show()
