--projectFolderPath= (pathConfig.getCurrentProjectFolder())
--MapsPath=(pathConfig.getProjectSubDirectory 6)
--format "maps path=%" MapsPath
--RelativePath=pathConfig.convertPathToRelativeTo MapsPath projectFolderPath
fn RMGuessFilePath FilenameAndPath = (
	if doesFileExist  FilenameAndPath then
		return FilenameAndPath
	else
		(
			Filename=filenameFromPath  FilenameAndPath
			searchfor= (maxFilePath +Filename )
			if (doesFileExist  searchfor)==true do
				return searchfor
			searchfor= (maxFilePath +"maps\\" +Filename )
			if (doesFileExist  searchfor)==true do
				return searchfor
			
			
		)
	return false
	)
fn RMGetBitmapFileAssetList =(
	FilePath=(maxFilePath+maxFileName)
	FileAssets=getMAXFileAssetMetadata FilePath
	assetIndex =#()
	for SceneAsset in FileAssets do
	(   AFile=SceneAsset.filename
		if SceneAsset.type==#Bitmap then
			(
				append assetIndex AFile
				FileNameArray=filterString AFile "\\"
				FileName=FileNameArray[FileNameArray.count]
			)
			else
			(
				print "No Fue Bitmap"
				format "File:% \n"  AFile
			)
	)
	return assetIndex
)
fn RMStrippToRealPath =(
	FilePath=(maxFilePath+ maxFileName)
	FileAssets=getMAXFileAssetMetadata FilePath
	assetIndex=RMGetBitmapFileAssetList()
	for SceneAsset  in assetIndex do
		(
		for i=1 to FileAssets.count do
			(	
				if FileAssets[i].FileName==SceneAsset do
				(  	
					RealFilePath=RMGuessFilePath FileAssets[i].FileName
					if  RealFilePath !=false then 
					(
						FileAssets[i].filename=RealFilePath
					)
					else
					(
						format "No pude encontrar el archivo %"  FileAssets[i].filename
					)
				)
			)
		)
	saveMaxFile FilePath
	resetMaxFile #noPrompt
	setMAXFileAssetMetadata	FilePath FileAssets
	loadMaxFile FilePath quiet:true
)

fn RMStrippPath=(
	FilePath=(maxFilePath+ maxFileName)
	FileAssets=getMAXFileAssetMetadata FilePath
	assetIndex=RMGetBitmapFileAssetList()
	for SceneAsset  in assetIndex do
		(
		for i=1 to FileAssets.count do
			(	AFile=FileAssets[i].FileName
				if AFile==SceneAsset do
				(  
				print "cambie "
				print AFile
				FileNameArray=filterString AFile "\\"
				FileAssets[i].filename=FileNameArray[FileNameArray.count]
				print FileNameArray[FileNameArray.count]
				)
			)
		)
		saveMaxFile FilePath
		resetMaxFile #noPrompt	
		setMAXFileAssetMetadata	FilePath FileAssets
		loadMaxFile FilePath quiet:true
	
)