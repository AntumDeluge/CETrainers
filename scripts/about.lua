
local about = {}

-- displays an about dialog
about.showDialog = function()
	local W = 400
	local H = 480

	-- dialog to display information about trainer
	local aboutDialog = createForm(false)
	aboutDialog.setCaption("About")
	aboutDialog.setSize(W, H)

	-- main panel
	local panel = createPanel(aboutDialog)
	panel.Align = alClient
	panel.BorderStyle = bsNone

	-- description text
	local descr1 = createLabel(panel)
	descr1.setCaption("Trainer for")
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
	if UNSTABLE then
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
	local ceInfo = createLabel(panel)
	ceInfo.setCaption("Made with Cheat Engine 6.8.1 by Dark Byte")
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

	aboutDialog.centerScreen()

	-- show the dialog
	aboutDialog.showModal()
	-- free memory after dialog is closed
	aboutDialog.destroy()
end

return about