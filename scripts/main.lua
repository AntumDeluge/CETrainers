
-- main table
MMU = {}
MMU.name = "MMU Trainer"

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
local standalone = TrainerOrigin ~= nil

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
MainWindow.setCaption(MMU.name)


--- START: Menu Bar ---

-- create a menu bar for main window
local menuBar = createMainMenu(MainWindow)
local menuBarItems = menuBar.getItems()

-- "File" main menu
local menuFile = createMenuItem(menuBar)
menuFile.setCaption("File")

-- "Open" menu item
local miOpen = createMenuItem(menuFile)
miOpen.setCaption("Open Process")
miOpen.ShortCut = 16463
miOpen.onClick = function()
	local process = dofile("scripts/process.lua")
	local PID = process.attach()
	if PID ~= nil then
		MMU.processLabel.setCaption("Attached process: " .. tostring(PID))
	end
end

local bmpOpen = createPicture()
bmpOpen.loadFromFile("data/bitmap/menu/process.png")
miOpen.Bitmap = bmpOpen.getBitmap()

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

MMU.processLabel = createLabel(MainWindow)
MMU.processLabel.anchorSideLeft.control = MainWindow
MMU.processLabel.anchorSideLeft.side = asrCenter

local loadedProcess = getOpenedProcessID()
if loadedProcess > 0 then
	MMU.processLabel.setCaption("Attached process: " .. tostring(loadedProcess))
else
	MMU.processLabel.setCaption("Attached process:")
end

local record = dofile("scripts/record.lua")

local chkPanel = createPanel(MainWindow)
chkPanel.anchorSideTop.control = MMU.processLabel
chkPanel.anchorSideTop.side = asrBottom

local checkBoxes = {}
checkBoxes["inv"] = createCheckBox(chkPanel)
checkBoxes["inv"].setCaption("Invincible")
checkBoxes["id"] = createCheckBox(chkPanel)
checkBoxes["id"].setCaption("Instant Death")

local idx = 0
for _, c in pairs(checkBoxes) do
	c.setPosition(10, idx * 20)
	idx = idx + 1
end
idx = nil

local live = true

checkBoxes["inv"].OnChange = function()
	if live then
		local enabled = checkBoxes["inv"].Checked
		local ret = record.setEnabled("Invincibility", enabled)

		-- update check box in case of failure
		if ret ~= enabled then
			live = false
			checkBoxes["inv"].Checked = ret
			live = true
		end
	end
end

checkBoxes["id"].OnChange = function()
	if live then
		local enabled = checkBoxes["id"].Checked
		local ret = record.setEnabled("Instant Death", enabled)

		-- update check box in case of failure
		if ret ~= enabled then
			live = false
			checkBoxes["id"].Checked = ret
			live = true
		end
	end
end

-- make main window visible
MainWindow.centerScreen()
MainWindow.show()
