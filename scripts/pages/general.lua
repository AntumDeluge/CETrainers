
local pgGeneral = nil

local checkboxes = {
	{'Instant Death', 'Ends turn as soon as Mega Man is damaged.',},
	{'Auto End Stage', 'Loads continue screen regardless of how many lives are left.',},
}

if mmu.small then
	pgGeneral = mmu.Tabs
else
	pgGeneral = mmu.Tabs.addTab()
	pgGeneral.setCaption('General')

	mmu.tableConcat(checkboxes, {
		'Infinite Lives',
		'Infinite Weapon Energy',
		'Invincibility',
		'10+ Lives',
		'No Shot Limit',
	})
end

for _, c in pairs(checkboxes) do
	local name = nil
	local helpstring = nil

	if type(c) == 'table' and #c > 0 then
		name = c[1]
		if #c > 1 then
			helpstring = c[2]
		end
	else
		name = c
	end

	local ctrl = mmu.createControl('check', name, pgGeneral)

	if helpstring ~= nil then
		ctrl.setHelpString('General Controls', helpstring)
	else
		ctrl.setHelpString('General Controls')
	end
end

return pgGeneral
