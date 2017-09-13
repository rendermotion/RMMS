for i=1 to 80 do
	(
	sliderTime = i
	b=snapshot $Calamar_PointCache

	if i==1 then
		WM3_MC_BuildFromNode $Calamar_Morpher.morpher 1 b
	else
		WM3_AddProgressiveMorphNode $Calamar_Morpher.morpher 1 b
	delete b
	)