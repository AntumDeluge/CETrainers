
local about = {}
local ver = dofile('scripts/version.lua')

-- displays an about dialog
about.showDialog = function()
	local W = 400
	local H = 300

	-- dialog to display information about trainer
	local aboutDialog = createForm(false)
	aboutDialog.BorderStyle = bsDialog
	aboutDialog.setCaption("About " .. mmu.name)
	aboutDialog.setSize(W, H)

	-- main panel
	local panel = createPanel(aboutDialog)
	panel.Align = alClient
	panel.BorderStyle = bsNone

	-- description text
	local descr1 = createLabel(panel)
	if mmu.small then
		descr1.setCaption("Minimalist Trainer for")
	else
		descr1.setCaption("Trainer for")
	end
	descr1.Top = H / 4
	local descr2 = createLabel(panel)
	descr2.setCaption("Mega Man Unlimited")
	for _, d in pairs({descr1, descr2}) do
		d.Font.Size = 12
		--setProperty(d, "alignment", "taCenter")
		d.anchorSideLeft.control = panel
		d.anchorSideLeft.side = asrCenter
	end
	descr2.anchorSideTop.control = descr1
	descr2.anchorSideTop.side = asrBottom
	descr2.Font.Color = 0xFF0000
	descr2.Cursor = -21 -- variable "crHandPoint" does not work
	descr2.OnClick = function(sender)
		shellExecute("http://megaphilx.com/index.php/home/games/mega-man-unlimited/")
		descr2.Font.Color = 0x0000FF
	end

	local author = createLabel(panel)
	author.setCaption("Created by Jordan Irwin (AntumDeluge)")
	author.anchorSideLeft.control = panel
	author.anchorSideLeft.side = asrCenter
	author.anchorSideTop.control = descr2
	author.anchorSideTop.side = asrBottom
	author.BorderSpacing.top = 20

	local version = createLabel(panel)
	if ver.UNSTABLE then
		version.setCaption("This software is unstable and likely will not work correctly")
	else
		version.setCaption("Version: " .. ver.full)
	end
	version.anchorSideLeft.control = panel
	version.anchorSideLeft.side = asrCenter
	version.anchorSideTop.control = author
	version.anchorSideTop.side = asrBottom
	version.BorderSpacing.top = 20

	-- Cheat Engine info
	local ceArch = "32"
	if cheatEngineIs64Bit() then
		ceArch = "64"
	end
	local ceInfo = createLabel(panel)
	ceInfo.setCaption("Made with Cheat Engine " .. tostring(getCEVersion()) .. " " .. ceArch .. "-bit by Dark Byte")
	ceInfo.anchorSideLeft.control = panel
	ceInfo.anchorSideLeft.side = asrCenter
	ceInfo.anchorSideTop.control = version
	ceInfo.anchorSideTop.side = asrBottom
	ceInfo.BorderSpacing.top = 20
	ceInfo.Font.Color = 0xFF0000
	ceInfo.Cursor = -21 -- variable "crHandPoint" does not work
	ceInfo.OnClick = function(sender)
		shellExecute("https://cheatengine.org/")
		ceInfo.Font.Color = 0x0000FF
	end

	-- place dialog over main window
	local x_comp = (MainWindow.Width - aboutDialog.Width) / 2
	local y_comp = (MainWindow.Height - aboutDialog.Height) / 2
	aboutDialog.Left = MainWindow.Left + x_comp
	aboutDialog.Top = MainWindow.Top + y_comp

	-- show the dialog
	aboutDialog.showModal()
	-- free memory after dialog is closed
	aboutDialog.destroy()
end

return about
