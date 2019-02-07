
-- run as standalone executable
local standalone = TrainerOrigin ~= nil

-- create main window but do not show it yet
local MainWindow = createForm(false)
MainWindow.setCaption("MMU Trainer")

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

-- action to take when "X-ed" out of
MainWindow.onClose = shutdown

-- make main window visible
MainWindow.show()
