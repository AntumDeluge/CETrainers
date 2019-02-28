
local about = {}
local ver = dofile('scripts/version.lua')


-- displays an about dialog
about.showDialog = function()
	local W = 400
	local H = 300

	-- dialog to display information about trainer
	local aboutDialog = createForm(false)
	aboutDialog.BorderStyle = bsDialog
	aboutDialog.setCaption('About ' .. mmu.name)
	aboutDialog.setSize(W, H)

	-- main panel
	local panel = createPanel(aboutDialog)
	panel.Align = alClient
	panel.BorderStyle = bsNone

	-- description text
	local descr1 = createLabel(panel)
	if mmu.small then
		descr1.setCaption('Minimalist Trainer for')
	else
		descr1.setCaption('Trainer for')
	end
	descr1.Top = H / 4
	local descr2 = createLabel(panel)
	descr2.setCaption('Mega Man Unlimited')
	for _, d in pairs({descr1, descr2}) do
		d.Font.Size = 12
		--setProperty(d, 'alignment', 'taCenter')
		d.anchorSideLeft.control = panel
		d.anchorSideLeft.side = asrCenter
	end
	descr2.anchorSideTop.control = descr1
	descr2.anchorSideTop.side = asrBottom
	descr2.Font.Color = 0xFF0000
	descr2.Cursor = -21 -- variable "crHandPoint" does not work
	descr2.OnClick = function(sender)
		shellExecute('http://megaphilx.com/index.php/home/games/mega-man-unlimited/')
		descr2.Font.Color = 0x0000FF
	end

	local author = createLabel(panel)
	author.setCaption('Created by Jordan Irwin (AntumDeluge)')
	author.anchorSideLeft.control = panel
	author.anchorSideLeft.side = asrCenter
	author.anchorSideTop.control = descr2
	author.anchorSideTop.side = asrBottom
	author.BorderSpacing.top = 20

	local version = createLabel(panel)
	if ver.UNSTABLE then
		version.setCaption('This software is unstable and likely will not work correctly')
	else
		version.setCaption('Version: ' .. ver.full)
	end
	version.anchorSideLeft.control = panel
	version.anchorSideLeft.side = asrCenter
	version.anchorSideTop.control = author
	version.anchorSideTop.side = asrBottom
	version.BorderSpacing.top = 20

	-- Cheat Engine info
	local ceArch = '32'
	if cheatEngineIs64Bit() then
		ceArch = '64'
	end
	local ceInfo = createLabel(panel)
	ceInfo.setCaption('Made with Cheat Engine ' .. tostring(getCEVersion()) .. ' ' .. ceArch .. '-bit by Dark Byte')
	ceInfo.anchorSideLeft.control = panel
	ceInfo.anchorSideLeft.side = asrCenter
	ceInfo.anchorSideTop.control = version
	ceInfo.anchorSideTop.side = asrBottom
	ceInfo.BorderSpacing.top = 20
	ceInfo.Font.Color = 0xFF0000
	ceInfo.Cursor = -21 -- variable "crHandPoint" does not work
	ceInfo.OnClick = function(sender)
		shellExecute('https://cheatengine.org/')
		ceInfo.Font.Color = 0x0000FF
	end

	local luaInfo = createLabel(panel)
	luaInfo.setCaption('Lua version ' .. _VERSION)
	luaInfo.AnchorSideLeft.Control = panel
	luaInfo.AnchorSideLeft.Side = asrCenter
	luaInfo.AnchorSideTop.Control = ceInfo
	luaInfo.AnchorSideTop.Side = asrBottom

	-- place dialog over main window
	mmu.centerOnMainWindow(aboutDialog)

	-- show the dialog
	aboutDialog.showModal()
	-- free memory after dialog is closed
	aboutDialog.destroy()
end


-- displays a dialog with help information
about.showHelp = function()
	local W = 400
	local H = 300

	-- dialog to display information about trainer
	local helpDialog = createForm(false)
	helpDialog.BorderStyle = bsDialog
	helpDialog.setCaption(mmu.name .. ' Usage')
	helpDialog.setSize(W, H)

	local textArea = createMemo(helpDialog)
	textArea.Align = alClient
	textArea.ReadOnly = true
	textArea.setScrollbars(ssAutoVertical)

	local text = mmu.createStringBuilder()
	text.append('Trainer for Mega Man Unlimited --\n\nDescription:\n')
	if mmu.small then
		text.prepend('Minimal ')
	end
	text.prepend('-- ')

	if mmu.small then
		text.append('  This trainer only provides minimal functionality.')
	else
		text.append('  This is the full trainer.')
	end

	local sections = {}
	-- fill in section information
	for _, ctrl in pairs(mmu.controls) do
		if ctrl.HelpSection ~= nil then
			if sections[ctrl.HelpSection] == nil then
				sections[ctrl.HelpSection] = mmu.createStringBuilder()
			end
		end

		if ctrl.HelpString ~= nil then
			sections[ctrl.HelpSection].append('\n  - ' .. ctrl.Control.Caption .. ': ' .. ctrl.HelpString)
		elseif ctrl.HelpSection ~= nil then
			sections[ctrl.HelpSection].append('\n  - ' .. ctrl.Control.Caption .. ' (no description)')
		end
	end

	if not mmu.small then
		local sb = mmu.createStringBuilder('\n  - Enables/Disables individual tools/weapons.')
		sections['Tools/Weapons'] = sb
	end

	for sect, sb in pairs(sections) do
		text.append('\n\n' .. sect .. ':')
		text.append(sb.toString())
	end

	textArea.append(text.toString())
	text.destroy()

	mmu.centerOnMainWindow(helpDialog)
	helpDialog.showModal()
	helpDialog.destroy()
end


return about
