
local pgEnergy = tabs.addTab()
pgEnergy.setCaption('Energy')

--- Record for infinite weapon energy
local recInfinite = record.get('Infinite Weapon Energy')

-- Setup GUI

local chkInfinite = createCheckBox(pgEnergy)
chkInfinite.setCaption(recInfinite.Description)
if recInfinite.Active then
	chkInfinite.setState(cbChecked)
else
	chkInfinite.setState(cbUnchecked)
end

chkInfinite.OnChange = function()
	recInfinite.Active = chkInfinite.Checked
end

return pgEnergy
