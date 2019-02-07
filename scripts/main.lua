
-- trainer version
ver = {}
ver.maj = 0
ver.min = 1
ver.rel = 0
ver.beta = 1
ver.full = string.format("%i.%i.%i", ver.maj, ver.min, ver.rel)
if ver.beta > 0 then
	ver.full = string.format("%s-beta%i", ver.full, ver.beta)
end

-- TODO: remove when stable
UNSTABLE = true

-- run as standalone executable
local standalone = TrainerOrigin == nil

-- create main window but do not show it yet
MainWindow = createForm(false)
MainWindow.BorderStyle = bsSizeable

-- icon displayed in the main interface
local icon = createPicture()
icon.loadFromFile("data/bitmap/icon.png")
MainWindow.Icon = icon.getBitmap()


-- closes trainer
local function shutdown()
	-- free memory allocated for the main interface
	MainWindow.destroy()

	-- trainer is run as a standalone executable
	if standalone then
		-- shuts down the main CE process
		closeCE()
		return caFree
	end
end

-- text displayed in title bar
MainWindow.setCaption("MMU Trainer")


--- START: Menu Bar ---

-- create a menu bar for main window
local menuBar = createMainMenu(MainWindow)
local menuBarItems = menuBar.getItems()

-- "File" main menu
local menuFile = createMenuItem(menuBar)
menuFile.setCaption("File")

-- "Open" menu item
local miOpen = createMenuItem(menuFile)
miOpen.setCaption("Open")
miOpen.ShortCut = 16463
miOpen.onClick = function()
end

-- "Quit" menu item
local miQuit = createMenuItem(menuFile)
miQuit.setCaption("Quit")
miQuit.onClick = shutdown

local bmpQuit = createPicture()
bmpQuit.loadFromFile("data/bitmap/menu/quit.png")
miQuit.Bitmap = bmpQuit.getBitmap()

menuFile.add(miOpen)
menuFile.add(miQuit)

-- "Help" main menu
local menuHelp = createMenuItem(menuBar)
menuHelp.setCaption("Help")

-- "About" menu item
local miAbout = createMenuItem(menuHelp)
miAbout.setCaption("About")
miAbout.onClick = function()
	local about = dofile("scripts/about.lua")
	about.showDialog()
end

menuHelp.add(miAbout)

-- add items to menu bar
menuBar.Items.add(menuFile)
menuBar.Items.add(menuHelp)

MainWindow.setMenu(menuBar)

--- END: Menu Bar ---


-- action to take when "X-ed" out of
MainWindow.onClose = shutdown

-- make main window visible
MainWindow.centerScreen()
MainWindow.show()
