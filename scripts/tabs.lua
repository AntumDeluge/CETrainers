
local tabs = createPageControl(MainWindow)

tabs.anchorSideTop.control = MMU.processLabel
tabs.anchorSideTop.side = asrBottom
--tabs.Left = 5
tabs.Align = alBottom
tabs.Anchors = {
	akTop = true,
	akBottom = true,
	akLeft = true,
	akRight = true,
}

return tabs
