
local tabs = nil
if mmu.small then
	tabs = createPanel(MainWindow)
else
	tabs = createPageControl(MainWindow)
end

tabs.AnchorSideTop.Control = mmu.processLabel
tabs.AnchorSideTop.Side = asrBottom
tabs.AnchorSideBottom.Control = MainWindow
tabs.AnchorSideBottom.Side = asrBottom
tabs.AnchorSideLeft.Control = MainWindow
tabs.AnchorSideLeft.Side = asrLeft
tabs.AnchorSideRight.Control = MainWindow
tabs.AnchorSideRight.Side = asrRight
tabs.Anchors = '[akTop,akBottom,akLeft,akRight]'
tabs.BorderSpacing.Left = 2
tabs.BorderSpacing.Bottom = 2

return tabs
