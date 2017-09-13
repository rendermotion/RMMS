fn BitArrayToArray BitArrayValues=
(
n=0
ResultArray=#()

	for n=1 to BitArrayValues.count do
	(
		if BitArrayValues[n] == true do
			append ResultArray (n-1)
	)
return ResultArray
)

fn TurnOffLayers LayerArray=(
	for i in LayerArray do
		(
				CurrentLayer=LayerManager.getLayer i
				CurrentLayer.on= false
		)	
	)

fn NetRenderLayers LayerArray OutputPath=(
	
	Tokens1=filterString OutputPath "\\"
	
	ActiveCam=(getActiveCamera())
	manager = NetRender.GetManager() 
	
	if manager!=undefined do
	(	
		print ("ableto Create Manager")
	)
	manager.connect #manual "server" 
	manager.getcontrol()
	if manager.connected ==true do
		   print ("Connection Success")
	for i in LayerArray do 
			(   TurnOffLayers LayerArray
				CurrentLayer=LayerManager.getLayer i
				CurrentLayer.on= TRUE
				--rendoutputfilename =(OutputPath + CurrentLayer.name +".exr")
				job = manager.newJob()
				Tokens = filterString maxFileName "."
				job.name =(Tokens[1]+"_"+CurrentLayer.name)
				job.frameOutputName=(OutputPath +Tokens1[Tokens1.count-3]+"_"+CurrentLayer.name +"_.exr")
				job.fromFrame=0
				job.toFrame=0
				job.Submit()
				
			)
	
	manager.Disconnect()

)
LayerName=#()
NLay = LayerManager.count
print NLay
for n=0 to NLay-1 do 
	(
	   Clay = LayerManager.getLayer n
		append LayerName Clay.name
	)
--InitialPath=maxFilePath
--f = getSaveFileName caption: "FolderToSave:" filename:InitialPath

rollout WhilrpoolRollout "NetRender" width:400 height:320
(
	multiListBox LayerMListBox "layers" pos:[9,15] width:136 height:20
	button NetRenderButton "NetRender" pos:[154,33] width:68 height:21
	radioButtons ObjType "Tipo de Objeto" pos:[152,65] width:87 height:110 labels:#("Parrillas", "Refrigeradores","Hornos","Estufas","Lavavajillas","Campanas","Microondas")
	radioButtons ImageNumber "Imagen" pos:[155,219] width:64 height:46 labels:#("Vista01", "Vista02")
	on NetRenderButton pressed do
	(
		TipodeObj= #("Parrillas", "Refrigeradores","Hornos","Estufas","Lavavajillas","Campanas","Microondas")
		Vista = #("Vista01", "Vista02")
		
		OutputPath= (MaxFilePath+"RenderOutput\\"+Vista[ImageNumber.state]+"\\"+TipodeObj[ObjType.state]+"\\")
		print "hola Mundo"
		g=LayerMListBox.selection
		print g
		print g.count
		NetRenderLayers (BitArrayToArray g) OutputPath
		)
)
WirlpoolWindow=newrolloutfloater "Whirlpool" 300 350
addrollout WhilrpoolRollout WirlpoolWindow
WhilrpoolRollout.LayerMListBox.items= LayerName