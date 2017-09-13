Atributos=attributes PolaridadParam(
	parameters Pol rollout:PolRoll
		(
		Polaridad type:#float ui:(PolESp, PolESl)
		)
	Rollout PolRoll "Peso"
		(
		spinner PolESp "" offset:[0,0] range:[-1,1,1]
		slider  PolESl "Peso" offset:[0,-20] range:[-1,1,1]
		)
	)
custAttributes.add  $.modifiers[#AttributeHolder] Atributos