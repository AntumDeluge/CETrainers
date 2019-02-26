
-- create a menu bar for main window
local menuBar = createMainMenu(MainWindow)
local menuBarItems = menuBar.getItems()

-- 'File' main menu
local menuFile = createMenuItem(menuBar)
menuFile.setCaption('File')

-- 'Open' menu item
local miOpen = createMenuItem(menuFile)
local pName = nil
miOpen.setCaption('Open Process')
miOpen.ShortCut = 16463
miOpen.onClick = function()
	local process = dofile('scripts/process.lua')
	pName, modalResult = process.setName(pName)
	if modalResult == 1 and pName ~= nil then
		local PID = process.attach(pName)
		if PID ~= nil then
			mmu.processLabel.setCaption('Attached process: ' .. tostring(PID))
		end
	end
end

local bmpOpen = createPicture()
bmpOpen.loadFromFile('data/bitmap/menu/process.png')
miOpen.Bitmap = bmpOpen.getBitmap()

--- 'Refresh' menu item.
--
-- Used to update controls in case of being disabled.
local miRefresh = createMenuItem(menuFile)
miRefresh.setCaption('Refresh Controls')
miRefresh.onClick = refreshControls

local bmpRefresh = createPicture()
bmpRefresh.loadFromFile('data/bitmap/menu/refresh.png')
miRefresh.Bitmap = bmpRefresh.getBitmap()

-- 'Quit' menu item
local miQuit = createMenuItem(menuFile)
miQuit.setCaption('Quit')
miQuit.onClick = shutdown

local bmpQuit = createPicture()
bmpQuit.loadFromFile('data/bitmap/menu/quit.png')
miQuit.Bitmap = bmpQuit.getBitmap()

menuFile.add(miOpen)
menuFile.add(miRefresh)
menuFile.add(miQuit)

-- 'Help' main menu
local menuHelp = createMenuItem(menuBar)
menuHelp.setCaption('Help')

-- 'About' menu item
local miAbout = createMenuItem(menuHelp)
miAbout.setCaption('About')
miAbout.onClick = function()
	local about = dofile('scripts/about.lua')
	about.showDialog()
end

menuHelp.add(miAbout)

-- add items to menu bar
menuBar.Items.add(menuFile)
menuBar.Items.add(menuHelp)

MainWindow.setMenu(menuBar)
