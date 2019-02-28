
local pgGeneral = nil

local checkboxes = {
	{'Instant Death', 'Ends turn as soon as Mega Man is damaged.',},
	{'Auto End Stage', 'Loads continue screen after turn ends regardless of how many lives are left.',},
}

if mmu.Small then
	pgGeneral = mmu.Tabs
else
	pgGeneral = mmu.Tabs.addTab()
	pgGeneral.setCaption('General')

	mmu.tableConcat(checkboxes, {
		{'Infinite Lives', 'Mega Man\'s lives will not decrease.',},
		{'Infinite Weapon Energy', 'Special tools & weapons energy will not be depleted when used.',},
		{'Invincibility', 'Mega Man takes no damage when colliding with enemies.',},
		{'10+ Lives', 'Mega Man is not limited to a maximum of 9 lives (does not work in shop menu).',},
		{'No Shot Limit', 'Mega Man can fire more than 3 shots at a time (applies to special weapons).',},
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
