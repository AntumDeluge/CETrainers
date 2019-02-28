
local pgTools = mmu.Tabs.addTab()
pgTools.setCaption('Tools/Weapons')
pgTools.AutoScroll = true

--- Parent node/header record.
local parentID = 215
local recTools = mmu.Record.get(parentID, true)

local idx = 0
while idx < recTools.Count do
	mmu.createControl('checkvalue', recTools[idx], pgTools)
	idx = idx + 1
end

return pgTools
