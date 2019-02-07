
-- run as standalone executable
local standalone = TrainerOrigin ~= nil

-- create main window but do not show it yet
local MainWindow = createForm(false)

-- closes trainer
local function shutdown()
	MainWindow.destroy()

	-- trainer is run as a standalone executable
	if TrainerOrigin == nil then
		-- shuts down the main CE process
		closeCE()
		return caFree
	end
end

-- text displayed in title bar
MainWindow.setCaption("MMU Trainer")

-- action to take when "X-ed" out of
MainWindow.onClose = shutdown


--- START: Menu Bar ---

-- create a menu bar for main window
local menuBar = createMainMenu(MainWindow)
local menuBarItems = menuBar.getItems()

-- "File" menu
local menuFile = createMenuItem(menuBar)
menuFile.setCaption("File")

-- "Open" menu item
local menuFileOpen = createMenuItem(menuFile)
menuFileOpen.setCaption("Open")
menuFileOpen.onClick = function()
end

menuFile.add(menuFileOpen)

-- add items to menu bar
menuBar.Items.add(menuFile)

MainWindow.setMenu(menuBar)

--- END: Menu Bar ---


-- make main window visible
MainWindow.centerScreen()
MainWindow.show()
