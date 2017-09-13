ca=attributes PieParam(
	parameters PPie rollout:CtrlPie
		(
		
		DesplanteP type:#float ui:(DesplanteSP,DesplanteSL)
		
		Punta type:#float ui:(PuntaSP,PuntaSL)
		
		Extremos type:#float ui:(ExtremosSP,ExtremosSL)
		
		Rodilla type:#float ui:(RodillaSP,RodillaSL)

		)
	Rollout CtrlPie "Control Pie"
		(
		spinner DesplanteSP "" offset:[0,0] range:[0,90,0]
		slider DesplanteSL "Desplante" offset:[0,-20] range:[0,90,0]
		
		spinner PuntaSP "" offset:[0,0] range:[-90,90,0]
		slider PuntaSL "Punta" offset:[0,-20] range:[-90,90,0]
		
		spinner ExtremosSP "" offset:[0,0] range:[-90,90,0]
		slider ExtremosSL "Extremos" offset:[0,-20] range:[-90,90,0]

		spinner RodillaSP "" offset:[0,0] range:[-90,90,0]
		slider RodillaSL "Rodilla" offset:[0,-20] range:[-90,90,0]
		
		button Reset "reset"
	
		on Reset pressed do (
			DesplanteP=0
			Punta=0
			Extremos=0
			Rodilla=0
			)
		
		)
)
custAttributes.add $.modifiers[1] ca

