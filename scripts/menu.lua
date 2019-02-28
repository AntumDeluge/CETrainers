
-- create a menu bar for main window
local menuBar = createMainMenu(mmu.Frame)
local menuBarItems = menuBar.getItems()

-- 'File' main menu
local menuFile = createMenuItem(menuBar)
menuFile.setCaption('File')

-- Picture object to load icons for menu items
local icon = createPicture()

-- Function to retrieve an icon for use with menu items.
local getIcon = function(img)
	icon.loadFromFile('data/bitmap/menu/' .. img .. '.png')
	return icon.getBitmap()
end

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
miOpen.Bitmap = getIcon('process')

--- 'Refresh' menu item.
--
-- Used to update controls in case of being disabled.
local miRefresh = createMenuItem(menuFile)
miRefresh.setCaption('Refresh Controls')
miRefresh.Shortcut = 'Ctrl+R'
miRefresh.onClick = mmu.refreshControls
miRefresh.Bitmap = getIcon('refresh')

-- 'Quit' menu item
local miQuit = createMenuItem(menuFile)
miQuit.setCaption('Quit')
miQuit.onClick = mmu.shutdown
miQuit.Bitmap = getIcon('quit')

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
miAbout.Bitmap = getIcon('info')

-- 'Help' menu item
local miHelp = createMenuItem(menuHelp)
miHelp.setCaption('Help')
miHelp.onClick = function()
	local about = dofile('scripts/about.lua')
	about.showHelp()
end
miHelp.Bitmap = getIcon('help')

menuHelp.add(miAbout)
menuHelp.add(miHelp)

-- add items to menu bar
menuBar.Items.add(menuFile)
menuBar.Items.add(menuHelp)

-- generating icons no longer needed
icon.destroy()

mmu.Frame.setMenu(menuBar)
