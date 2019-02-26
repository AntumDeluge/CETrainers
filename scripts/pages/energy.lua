
local pgEnergy = tabs.addTab()
pgEnergy.setCaption('Energy')

--- Record for infinite weapon energy
createControl('check', 'Infinite Weapon Energy', pgEnergy)

return pgEnergy
