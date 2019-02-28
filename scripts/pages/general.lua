
local pgGeneral = nil

local checkboxes = {
	{'Instant Death', 'Ends turn as soon as Mega Man is damaged.', true},
	{'Auto End Stage', 'Loads continue screen after turn ends regardless of how many lives are left.', true,},
}

if mmu.Small then
	pgGeneral = mmu.Tabs
else
	pgGeneral = mmu.Tabs.addTab()
	pgGeneral.setCaption('General')

	mmu.tableConcat(checkboxes, {
		{'Infinite Lives', 'Mega Man\'s lives will not decrease.', true,},
		{'Infinite Weapon Energy', 'Special tools & weapons energy will not be depleted when used.', true,},
		{'Invincibility', 'Mega Man takes no damage when colliding with enemies.', true,},
		{'10+ Lives', 'Mega Man is not limited to a maximum of 9 lives (does not work in shop menu).', true,},
		{'No Shot Limit', 'Mega Man can fire more than 3 shots at a time (applies to special weapons).', true,},
	})
end

for _, c in pairs(checkboxes) do
	local name = nil
	local helpstring = nil
	local release = nil

	if type(c) == 'table' and #c > 0 then
		name = c[1]
		if #c > 1 then
			helpstring = c[2]
			if #c > 2 then
				release = c[3]
			end
		end
	else
		name = c
	end

	local ctrl = mmu.createControl('check', name, pgGeneral, nil, nil, release)

	if helpstring ~= nil then
		ctrl.setHelpString('General Controls', helpstring)
	else
		ctrl.setHelpString('General Controls')
	end
end

return pgGeneral
