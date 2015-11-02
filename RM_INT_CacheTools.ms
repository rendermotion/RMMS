ScriptPath="\\\\SERVER\\Alumnos\\Rigging\\Recursos\\Includes\\"
filein (ScriptPath+"RMPointCacheFunctions.ms")

rollout PointCacheRollout "Point Cache" width:344 height:189
(
	
	button ExportCacheBtn "Export Selected as Cache" pos:[16,17] width:155 height:29
	button ExportMeshBtn "Export Selected Mesh" pos:[8,64] width:156 height:28
	button LoadCacheBtn "LoadCacheData" pos:[176,64] width:156 height:28
	
	checkbox chk1 "Export Selected Mesh" pos:[192,24] width:123 height:18
	GroupBox grp1 "Cash Export" pos:[7,1] width:327 height:56
	
	button btn4 "Select CavemanGeo" pos:[8,107] width:156 height:28
	button btn5 "Select SheepGeo" pos:[180,107] width:156 height:28
	button btn6 "Select Castor Geo" pos:[9,148] width:156 height:28
	on ExportCacheBtn pressed do
	(
		if chk1.checked==1 then
			RMExportSelectionCache ()
		else
			RMExportSelectionCache saveCacheNodes:False
	)
	on ExportMeshBtn pressed do
	(  
		RMSaveCacheNodes ()
	)
	on LoadCacheBtn pressed do
	(
		RMLoadCharacterCash ()
	)
	on btn4 pressed do
	(
		select $Caveman*msh_ful

	)
	on btn5 pressed do
	(
		select $Sheep*msh_ful
	)
	on btn6 pressed do
	(
		select $Castor*msh_ful
	)
)
CacheToolsFloater = newRolloutFloater "Point Cache Functions" 350 300
addRollout PointCacheRollout CacheToolsFloater