local pgGeneral = tabs.addTab()
pgGeneral.setCaption('General')

local checkBoxes = {
	'Instant Death',
	'Infinite Lives',
	'Infinite Weapon Energy',
	'Invincibility',
	'10+ Lives',
	'Auto End Stage',
	'No Shot Limit',
}

for _, c in pairs(checkBoxes) do
	mmu.createControl('check', c, pgGeneral)
end

return pgGeneral
