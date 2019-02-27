
-- trainer version
local ver = {}
ver.maj = 0
ver.min = 1
ver.rel = 0
ver.beta = 2
ver.full = string.format('%i.%i.%i', ver.maj, ver.min, ver.rel)
if ver.beta > 0 then
	ver.full = string.format('%s-beta%i', ver.full, ver.beta)
end

-- shows an unstable message instead of version info in about dialog if set to "true"
ver.UNSTABLE = false

return ver
