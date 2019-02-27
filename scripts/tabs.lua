
local tabs = nil
if mmu.small then
	tabs = createPanel(mmu.Frame)
else
	tabs = createPageControl(mmu.Frame)
end

tabs.AnchorSideTop.Control = mmu.processLabel
tabs.AnchorSideTop.Side = asrBottom
tabs.AnchorSideBottom.Control = mmu.Frame
tabs.AnchorSideBottom.Side = asrBottom
tabs.AnchorSideLeft.Control = mmu.Frame
tabs.AnchorSideLeft.Side = asrLeft
tabs.AnchorSideRight.Control = mmu.Frame
tabs.AnchorSideRight.Side = asrRight
tabs.Anchors = '[akTop,akBottom,akLeft,akRight]'
tabs.BorderSpacing.Left = 2
tabs.BorderSpacing.Bottom = 2

return tabs
