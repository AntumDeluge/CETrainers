
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

	-- polls record value to catch changes
	local prevValue = nil
	rec.OnGetDisplayValue = function(sender, curValue)
		local changed = prevValue and (prevValue ~= curValue)
		prevValue = curValue

		if changed then
			chk.OnChange(rec)
		end

		return false, curValue
	end

	-- function to prevent redundant changes to value & check box state
	local synchronized = function()
		if (not chk.Checked and rec.Value == '0') or (chk.Checked and rec.Value ~= '0') then
			return true
		end

		return false
	end

	chk.OnChange = function(sender)
		if not synchronized() then
			if sender == chk then
				if chk.Checked then
					rec.Value = '1'
				else
					rec.Value = '0'
				end
			elseif sender == rec then
				chk.Checked = rec.Value ~= '0'
			end
		end
	end

	if prevChk ~= nil then
		chk.anchorSideTop.control = prevChk
		chk.anchorSideTop.side = asrBottom
	end

	prevChk = chk
end
prevChk = nil

return tools
