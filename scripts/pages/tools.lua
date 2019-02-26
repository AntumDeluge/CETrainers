
local tools = tabs.addTab()
tools.setCaption('Tools/Weapons')
tools.AutoScroll = true

--- Parent node/header record.
local parentID = 215
local recTools = record.get(parentID, true)

local idx = 0
while idx < recTools.Count do
	createControl('checkvalue', recTools[idx], tools)
	idx = idx + 1
end

return tools
