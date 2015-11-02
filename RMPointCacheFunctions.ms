	ScriptPath="\\\\SERVER\\Alumnos\\Rigging\\Recursos\\Includes\\"
	filein (ScriptPath+"RMCompareAndSort.ms")
	filein (ScriptPath+"RMNameConvention.ms")
	filein (ScriptPath+"RMRiggTools.ms")
	
	fn RMExportSelectionCache saveCacheNodes:True =(
		
		ObjetosSeleccionados=selection as array
		qsort ObjetosSeleccionados RMcompareNames
		
		print ObjetosSeleccionados
		
		
		CharacterName=(RMGetFromName ObjetosSeleccionados[1].name 1)
		
		
		ObjetosAttachados=snapshot ObjetosSeleccionados[1]
		
		ObjetosAttachados.parent=undefined 
		
		NewArray=RMResetTransformMatrix (#(ObjetosAttachados)) KeepPosition:False
		
		ObjetosAttachados=NewArray[1]
		convertToMesh ObjetosAttachados
		ObjetosAttachados.name=RMSetFromName ObjetosSeleccionados[1].name 3 (CharacterName+"PointCache")
		
		hide ObjetosSeleccionados[1]
		
		for i=2 to ObjetosSeleccionados.count do
		(
			ObjetoB=snapshot ObjetosSeleccionados[i]
			attach ObjetosAttachados ObjetoB
			hide ObjetosSeleccionados[i]
		)
		
		Modificador=skin_Wrap()
		addmodifier ObjetosAttachados Modificador
		Modificador.falloff = 0.03
		Modificador.distance = 0.03
		for i in ObjetosSeleccionados  do
			append Modificador.meshList i

		PC=Point_Cache()
		addmodifier ObjetosAttachados PC
		
		maxFilePath
		f=getDirectories (maxFilePath+"*")
		
		if makeDir (maxFilePath+"PointCache") do 
			if makeDir (maxFilePath+"\\PointCache\\"+CharacterName) then
				(
					PC.fileName=(maxFilePath+"\\PointCache\\"+CharacterName+"\\"+CharacterName+".xml")
					PC.fileCount=1--One File Per Frame
					
					cacheOps.RecordCache		PC
					)
				else
					messageBox "Unable to create Directories" Title:"Saving Problem"
		
		if saveCacheNodes do
			saveNodes ObjetosAttachados (maxFilePath+"\\PointCache\\"+CharacterName+".max")  quiet:False
	
	)
  fn RMSaveCacheNodes =(
	  
		ObjetosSeleccionados=selection as array
		qsort ObjetosSeleccionados RMcompareNames
	  
		print ObjetosSeleccionados
	  
		CharacterName=(RMGetFromName ObjetosSeleccionados[1].name 1)
		
		ObjetosAttachados=snapshot ObjetosSeleccionados[1]
		
		ObjetosAttachados.parent=undefined 
	  
		NewArray=RMResetTransformMatrix (#(ObjetosAttachados)) KeepPosition:False
		ObjetosAttachados=NewArray[1]
		convertToMesh ObjetosAttachados
		ObjetosAttachados.name=RMSetFromName ObjetosSeleccionados[1].name 3 (CharacterName+"PointCache")
		
			
	  	hide ObjetosSeleccionados[1]
		for i=2 to ObjetosSeleccionados.count do
		(
			ObjetoB=snapshot ObjetosSeleccionados[i]
			attach ObjetosAttachados ObjetoB
			hide ObjetosSeleccionados[i]
		)
		if makeDir (maxFilePath+"PointCache") do 
			if makeDir (maxFilePath+"\\PointCache\\"+CharacterName) then
				(
	  	saveNodes ObjetosAttachados (maxFilePath+"PointCache\\"+CharacterName+".max")  quiet:False
				)
				else
					messageBox "Unable to create Directories" Title:"Saving Problem"
		
	  )
	  
	fn RMLoadCharacterCash =(
		SelectedObjects=selection as array
		if SelectedObjects.count!=1 then 
			messageBox "Select Only One Object" Title:"User Problem"
		else 
			(	
				PCGeo=SelectedObjects[1]
				PC=Point_Cache()
				addmodifier PCGeo PC
				CharacterName=(RMGetFromName SelectedObjects[1].name 1)
				
				if doesFileExist (maxFilePath+"\\PointCache\\"+CharacterName+"\\"+CharacterName+".xml") then 
								PC.fileName=(maxFilePath+"\\PointCache\\"+CharacterName+"\\"+CharacterName+".xml")
				else 
					messageBox "No  previous Cache Recorded for Character" Title:"Cache Problem"
			)
		
		)
		
	
	