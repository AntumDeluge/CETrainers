
dofile('scripts/main.lua')

-- do this before importing window.lua
mmu.small = true

-- main window construction
dofile('scripts/window.lua')

-- record controls
local instantDeath = createControl('check', 'Instant Death', tabs)
local autoEndStage = createControl('check', 'Auto End Stage', tabs)

refreshControls()

MainWindow.show()
