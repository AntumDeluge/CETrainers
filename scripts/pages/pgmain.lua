local pgMain = tabs.addTab()
pgMain.setCaption('Main')

local chkPanel = createPanel(pgMain)
chkPanel.AutoSize = true
chkPanel.Left = 5
chkPanel.anchorSideTop.control = MMU.processLabel
chkPanel.anchorSideTop.side = asrBottom

local checkBoxes = {
	'Instant Death',
	'Infinite Lives',
	'Infinite Weapon Energy',
	'Invincibility',
	'10+ Lives',
	'Auto End Stage',
}

local idx = 0
for _, c in pairs(checkBoxes) do
	local chk = createCheckBox(chkPanel)
	chk.setCaption(c)
	if record.get(c).Active then
		chk.Checked = true
	end
	chk.OnChange = function()
		local enabled = chk.Checked
		local ret = record.setEnabled(c, enabled)
		
		-- update check box in case of failure
		if ret ~= enabled then
			showMessage('WARNING: Could not change record \'' .. c .. '\'. Is a process loaded?')
			chk.Checked = ret
		end
	end
	chk.setPosition(10, idx * 20)
	idx = idx + 1
end
idx = nil

return pgMain
