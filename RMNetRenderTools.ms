/*Esta función Renderea todas las cámaras que se le envíen en un Arreglo (Cam Array) en caso de que el arreglo no se envíe, manda a renderear todas las cámaras, 
el valor Prefijo indica el prefijo que se le dará al trabajo y a la salida de render al manager llamado server*/

fn RMRenderAllCams OutputPath prefix:"" CamArray:#() includeMaps:false=(
	Objetos=(Cameras as array)
	RenderCamera=#()
	RenderCameraAll=#()
	for i in Objetos do
	(
			if (classof i)== VRayPhysicalCamera do 
				append  RenderCameraAll i
	)
	if CamArray.count==0 then 
		RenderCamera=RenderCameraAll
	else
	(
	for n=1 to CamArray.count do
		append  RenderCamera RenderCameraAll[CamArray[n]]
	)
	
	manager = NetRender.GetManager() 

	if manager!=undefined do
	(	
		print ("ableto Create Manager")
	)
	manager.connect #manual "server" 
	Getcontrol=manager.getcontrol()
	if manager.connected ==true then 
			(print ("Connection Success")
			
			for i in RenderCamera do 
					(   
						job = manager.newJob()
						Tokens = filterString maxFileName "."
						
						RenderEngine=renderers.current
						RenderEngine.output_saveFile=TRUE
						RenderEngine.output_splitgbuffer=TRUE
						RenderEngine.output_splitRGB=TRUE
						RenderEngine.output_splitAlpha=TRUE
						RenderEngine.output_splitfilename =(OutputPath +(filterString Tokens[1] "_")[1]+"_"+i.name+"_"+prefix+"_.exr")
						RenderEngine.output_fileName=(OutputPath +(filterString Tokens[1] "_")[1]+"_"+i.name+"_"+prefix+"_.exr")

						job.name =(Tokens[1]+"_"+i.name+prefix)
						job.frameOutputName=(OutputPath +(filterString Tokens[1] "_")[1]+"_"+i.name+"_"+prefix+".exr")
						fopenexr.setLayerOutputFormat 0 0 
						fopenexr.setLayerOutputType 0 0						
						job.renderCamera=i.name
						job.nonSeqFrames=True
						job.frames ="0"
						--job.fromFrame=0
						--job.toFrame=0
						--job.includeMaps = includeMaps
						returned=job.Submit()
						print "Resultado del trabajo"
						print returned
						
					)
			manager.Disconnect()
			
			)
	else print "Unable to connect to manager"
)