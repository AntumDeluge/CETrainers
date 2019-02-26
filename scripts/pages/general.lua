local pgMain = tabs.addTab()
pgMain.setCaption('General')

local chkPanel = createPanel(pgMain)
chkPanel.AutoSize = true
chkPanel.Left = 5
chkPanel.anchorSideTop.control = mmu.processLabel
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
	createControl('check', c, chkPanel)
end
idx = nil

return pgMain
