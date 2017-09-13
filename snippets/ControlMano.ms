ca=attributes ManoParam(
	parameters PMano rollout:CtrlMano
		(
		
		DedoMeniqueP type:#float ui:(DedoMeniqueSP,DedoMeniqueSL)
		DedoMenique1P type:#float ui:(DedoMenique1SP,DedoMenique1SL)

		DedoAnular type:#float ui:(DedoAnularSP,DedoAnularSL)
		DedoAnular1 type:#float ui:(DedoAnular1SP,DedoAnular1SL)
		
		DedoMedio type:#float ui:(DedoMedioSP,DedoMedioSL)
		DedoMedio1 type:#float ui:(DedoMedio1SP,DedoMedio1SL)

		DedoIndice type:#float ui:(DedoIndiceSP,DedoIndiceSL)
		DedoIndice1 type:#float ui:(DedoIndice1SP,DedoIndice1SL)

		DedoPulgar type:#float ui:(DedoPulgarSP,DedoPulgarSL)
		Cup  type:#float ui:(CupSP,CupSL)
		
		Split  type:#float ui:(SplitSP,SplitSL)
		)
	Rollout CtrlMano "Control Dedos"
		(
		spinner DedoMeniqueSP "" offset:[0,0] range:[0,90,0]
		slider DedoMeniqueSL "Meñique_FP" offset:[0,-20] range:[0,90,0]
		spinner DedoMenique1SP "" offset:[0,0] range:[0,90,0]
		slider DedoMenique1SL "Meñique" offset:[0,-20] range:[0,90,0]
		
		spinner DedoAnularSP "" offset:[0,0] range:[0,90,0]
		slider DedoAnularSL "Anular_FP" offset:[0,-20] range:[0,90,0]
		spinner DedoAnular1SP "" offset:[0,0] range:[0,90,0]
		slider DedoAnular1SL "Anular" offset:[0,-20] range:[0,90,0]

		
		spinner DedoMedioSP "" offset:[0,0] range:[0,90,0]
		slider DedoMedioSL "Medio_FP" offset:[0,-20] range:[0,90,0]
		spinner DedoMedio1SP "" offset:[0,0] range:[0,90,0]
		slider DedoMedio1SL "Medio" offset:[0,-20] range:[0,90,0]


		spinner DedoIndiceSP "" offset:[0,0] range:[0,90,0]
		slider DedoIndiceSL "Indice_FP" offset:[0,-20] range:[0,90,0]
		
		spinner DedoIndice1SP "" offset:[0,0] range:[0,90,0]
		slider DedoIndice1SL "Indice" offset:[0,-20] range:[0,90,0]
		
		spinner DedoPulgarSP "" offset:[0,0] range:[0,90,0]
		slider DedoPulgarSL "Pulgar" offset:[0,-20] range:[0,90,0]
		
		spinner CupSP "" offset:[0,0] range:[0,90,0]
		slider CupSL "Cup" offset:[0,-20] range:[0,90,0]

		spinner SplitSP "" offset:[0,0] range:[-90,90,0]
		slider SplitSL "Split" offset:[0,-20] range:[-90,90,0]
		
		button Reset "reset"
	
		on Reset pressed do (
		DedoMeniqueP=0
		DedoMenique1P=0
		DedoAnular=0
		DedoAnular1=0

		
		DedoMedio=0
		DedoMedio1=0

		DedoIndice=0
		DedoIndice1=0


		DedoPulgar=0
		Cup=0
		Split=0
			)
		
		)
)
custAttributes.add $.modifiers[1] ca

