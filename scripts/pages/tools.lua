
local tools = tabs.addTab()
tools.setCaption('Tools/Weapons')
tools.AutoScroll = true

--- Parent node/header record.
local parentID = 215
local recTools = record.get(parentID, true)

for idx, rec in ipairs(recTools.Child) do
	-- FIXME: not all controls working
	createControl('checkvalue', rec.Description, tools)
end

return tools
