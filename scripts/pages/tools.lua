
local tools = tabs.addTab()
tools.setCaption('Tools/Weapons')
tools.AutoScroll = true

--- Parent node/header record.
local parentID = 215
local recTools = record.get(parentID, true)

local prevChk = nil
for idx, rec in ipairs(recTools.Child) do
	-- Create checkbox for each record.
	local chk = createCheckBox(tools)
	chk.setCaption(rec.Description)

	-- set active state
	if rec.IsReadable then
		chk.Checked = rec.Value == '1'
	end

	if prevChk ~= nil then
		chk.anchorSideTop.control = prevChk
		chk.anchorSideTop.side = asrBottom
	end

	prevChk = chk
end
prevChk = nil

return tools
