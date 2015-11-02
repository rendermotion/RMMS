fn RMAsigntoLayer LayerName Objetos AvoidNub:False =(
	Capa=LayerManager.getLayerFromName LayerName
	if  (Capa==undefined) do 
			Capa=LayerManager.newLayerFromName  LayerName
	if classof Objetos == Array or classof Objetos==ArrayParameter then
	(
		for i in objetos do
			(
				if not(AvoidNub==True and i == objetos[objetos.count]) do
					capa.addnode i
			)
	)
	else 
		capa.addnode Objetos
	)
	