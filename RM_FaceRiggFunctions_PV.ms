ScriptPath="\\\\SERVER\\Alumnos\\Rigging\\Recursos\\Includes\\"
filein (ScriptPath+"RMArrayTools.ms")
filein (ScriptPath+"RMMorpherTools.ms")

fn JawLink JawBone =(
	ObjectExist=False 
	if JawBone==undefined then
	(
		if(JawBone=$Character01_MD_jaw_jnt_rfr)!=undefined do
			ObjectExist=TRUE
	)
	else 
	(
		ObjectExist=TRUE
	)
	if ObjectExist != False do 
	(
	print "I am linking"
	paramWire.connect $Jaw_open_ctrl.pos.controller[#Z_Position] JawBone.rotation.controller[#Y_Rotation] "degtorad(if Z_position <-1 then 40 else( if Z_position>0 then 0 else -Z_Position*40))"
	paramWire.connect $Jaw_Fwd_ctrl.pos.controller[#Z_Position] JawBone.position.controller[#X_Position] "Z_Position/2"
	paramWire.connect $Jaw_Fwd_ctrl.pos.controller[#X_Position] JawBone.rotation.controller[#z_rotation] "X_Position"
	)
)

/*Funcion que Desabilita las banderas de la cadena que no se encuentre en la escena Es muy parecida a checa Morphers, pero regresa el arreglo de Verdaderos Falsos */
fn DisableFlags ObjectsNamesArray ExistanceArray=
	(
		for i in ObjectsNamesArray do
			if ((execute ("in objects $"+i))!=undefined) then 
				(
				if ((execute ("in objects $"+i)).name!=i) then
					ExistanceArray[RMGetIndexOfElementInArray  ObjectsNamesArray i]=False;
				else
					ExistanceArray[RMGetIndexOfElementInArray  ObjectsNamesArray i]=True;
				)
			else
					ExistanceArray[RMGetIndexOfElementInArray  ObjectsNamesArray i]=False;
	return ExistanceArray;
	)
	
/*Funcion que checa que existan los Objetos Listados en la Cadena Names se utiliza para checar los morphers Regresa una cadena con información para el usuario de los objetos que existen en la escena*/
fn RMMorphersCheck names=
	(
		CadenaInfo=" ";
		for i in names do
			if ((execute ("in objects $"+i))!=undefined) then 
				(
				if ((execute ("in objects $"+i)).name!=i) do
					CadenaInfo= CadenaInfo + ("no existe "+ i +"\n");
				)
			else
				CadenaInfo= CadenaInfo + ("no existe "+ i +"\n");
		if (CadenaInfo ==" ") do CadenaInfo = "OK";
			return CadenaInfo;
	)

fn LinkTonge CharacterOrig Names=(
	select $Tonge
	if (RMMorpherExist $Tonge==False) do
		(
			addmodifier  $Tonge (Morpher())
		
			n=1
	for i in Names do
			(		 
			WM3_MC_BuildFromNode $Tonge.modifiers["Morpher"]  n  (execute("$"+i))
			n=n+1;
			)
			WM3_AddProgressiveMorphNode $Tonge.modifiers["Morpher"] (RMGetMorphIndex  $Tonge "Jaw_Full_Open")  $TongeJaw_Half_Open
			WM3_SetProgressiveMorphWeight $Tonge.modifiers["Morpher"]  (RMGetMorphIndex  $Tonge "Jaw_Full_Open") $TongeJaw_Half_Open 50.0
			WM3_SetProgressiveMorphWeight $Tonge.modifiers["Morpher"]  (RMGetMorphIndex  $Tonge "Jaw_Full_Open") $TongeJaw_Full_Open 100.0
		)
			
			execute ("paramWire.connect $"+CharacterOrig.name+".modifiers[#Morpher]["+(RMGetMorphIndex  CharacterOrig "JawLeft") as string +"] $Tonge.modifiers[#Morpher]["+ (RMGetMorphIndex  $Tonge "TongeJawLeft") as string +"] \""+ (substituteString ((CharacterOrig.modifiers[#Morpher][(RMGetMorphIndex  CharacterOrig "JawLeft")])as string) "SubAnim:" "")+"_" +"\" ")
			execute ("paramWire.connect $"+CharacterOrig.name+".modifiers[#Morpher]["+(RMGetMorphIndex  CharacterOrig "JawRight") as string +"] $Tonge.modifiers[#Morpher]["+ (RMGetMorphIndex  $Tonge "TongeJawRight") as string +"] \""+ (substituteString ((CharacterOrig.modifiers[#Morpher][(RMGetMorphIndex  CharacterOrig "JawRight")])as string) "SubAnim:" "")+"_" +"\" ")
			execute ("paramWire.connect $"+CharacterOrig.name+".modifiers[#Morpher]["+(RMGetMorphIndex  CharacterOrig "Jaw_Full_Open") as string +"] $Tonge.modifiers[#Morpher]["+ (RMGetMorphIndex  $Tonge "TongeJaw_Full_Open") as string +"] \""+ (substituteString ((CharacterOrig.modifiers[#Morpher][(RMGetMorphIndex  CharacterOrig "Jaw_Full_Open")])as string) "SubAnim:" "")+"_" +"\" ")
			execute ("paramWire.connect $"+CharacterOrig.name+".modifiers[#Morpher]["+(RMGetMorphIndex  CharacterOrig "JawFwd") as string +"] $Tonge.modifiers[#Morpher]["+ (RMGetMorphIndex  $Tonge "TongeJawFwd") as string +"] \""+ (substituteString ((CharacterOrig.modifiers[#Morpher][(RMGetMorphIndex  CharacterOrig "JawFwd")])as string) "SubAnim:" "")+"_" +"\" ")
			execute ("paramWire.connect $"+CharacterOrig.name+".modifiers[#Morpher]["+(RMGetMorphIndex  CharacterOrig "JawBkwd") as string +"] $Tonge.modifiers[#Morpher]["+ (RMGetMorphIndex  $Tonge "TongeJawBkwd") as string +"] \""+ (substituteString ((CharacterOrig.modifiers[#Morpher][(RMGetMorphIndex  CharacterOrig "JawBkwd")])as string) "SubAnim:" "")+"_" +"\" ")
			execute ("paramWire.connect $"+CharacterOrig.name+".modifiers[#Morpher]["+(RMGetMorphIndex  CharacterOrig "WIDE") as string +"] $Tonge.modifiers[#Morpher]["+ (RMGetMorphIndex  $Tonge "TongeWide") as string +"] \""+ (substituteString ((CharacterOrig.modifiers[#Morpher][(RMGetMorphIndex  CharacterOrig "WIDE")])as string) "SubAnim:" "")+"_" +"\" ")
	)
	
/***********************************************************/
fn LinkTeeth CharacterOrig Teeth  Teeth_Flg Unique Unique_Flg=(
		if Unique_Flg[RMGetIndexOfElementInArray  Unique "Teeth_Dn"] do 
		(
			select $Teeth_Dn
			if (RMMorpherExist $Teeth_Dn==False) do
				(
					addmodifier  $Teeth_Dn (Morpher())
				n=1
				for i in Teeth do
					(		 
					if Teeth_Flg [RMGetIndexOfElementInArray  Teeth i]==true do 
						(
						WM3_MC_BuildFromNode $Teeth_Dn.modifiers["Morpher"]  n  (execute("$"+i))
						n=n+1;
						)
					)
				if Teeth_Flg[RMGetIndexOfElementInArray  Teeth "TJaw_Half_Open"]==true do WM3_AddProgressiveMorphNode $Teeth_Dn.modifiers["Morpher"] (RMGetMorphIndex  $Teeth_Dn "TJaw_Full_Open")  $TJaw_Half_Open
				if Teeth_Flg[RMGetIndexOfElementInArray  Teeth "TJaw_Half_Open"]==true do WM3_SetProgressiveMorphWeight $Teeth_Dn.modifiers["Morpher"]  (RMGetMorphIndex  $Teeth_Dn "TJaw_Full_Open") $TJaw_Half_Open 50.0
				if Teeth_Flg[RMGetIndexOfElementInArray  Teeth "TJaw_Full_Open"]==true do WM3_SetProgressiveMorphWeight $Teeth_Dn.modifiers["Morpher"]  (RMGetMorphIndex  $Teeth_Dn "TJaw_Full_Open") $TJaw_Full_Open 100.0
				)
				if Teeth_Flg[RMGetIndexOfElementInArray  Teeth "TJawLeft"]==true do   execute ("paramWire.connect $"+CharacterOrig.name+".modifiers[#Morpher]["+(RMGetMorphIndex  CharacterOrig "JawLeft") as string +"] $Teeth_Dn.modifiers[#Morpher]["+ (RMGetMorphIndex  $Teeth_Dn "TJawLeft") as string +"] \""+ (substituteString ((CharacterOrig.modifiers[#Morpher][(RMGetMorphIndex  CharacterOrig "JawLeft")])as string) "SubAnim:" "")+"_" +"\" ")
				if Teeth_Flg[RMGetIndexOfElementInArray  Teeth  "TJawRight"]==true do execute ("paramWire.connect $"+CharacterOrig.name+".modifiers[#Morpher]["+(RMGetMorphIndex  CharacterOrig "JawRight") as string +"] $Teeth_Dn.modifiers[#Morpher]["+ (RMGetMorphIndex  $Teeth_Dn "TJawRight") as string +"] \""+ (substituteString ((CharacterOrig.modifiers[#Morpher][(RMGetMorphIndex  CharacterOrig "JawRight")])as string) "SubAnim:" "")+"_" +"\" ")
				if Teeth_Flg[RMGetIndexOfElementInArray  Teeth "TJaw_Full_Open"]==true do execute ("paramWire.connect $"+CharacterOrig.name+".modifiers[#Morpher]["+(RMGetMorphIndex  CharacterOrig "Jaw_Full_Open") as string +"] $Teeth_Dn.modifiers[#Morpher]["+ (RMGetMorphIndex  $Teeth_Dn "TJaw_Full_Open") as string +"] \""+ (substituteString ((CharacterOrig.modifiers[#Morpher][(RMGetMorphIndex  CharacterOrig "Jaw_Full_Open")])as string) "SubAnim:" "")+"_" +"\" ")
				if Teeth_Flg[RMGetIndexOfElementInArray  Teeth "TJawFwd"]==true do execute ("paramWire.connect $"+CharacterOrig.name+".modifiers[#Morpher]["+(RMGetMorphIndex  CharacterOrig "JawFwd") as string +"] $Teeth_Dn.modifiers[#Morpher]["+ (RMGetMorphIndex  $Teeth_Dn "TJawFwd") as string +"] \""+ (substituteString ((CharacterOrig.modifiers[#Morpher][(RMGetMorphIndex  CharacterOrig "JawFwd")])as string) "SubAnim:" "")+"_" +"\" ")
				if Teeth_Flg[RMGetIndexOfElementInArray  Teeth "TJawBkwd"]==true do execute ("paramWire.connect $"+CharacterOrig.name+".modifiers[#Morpher]["+(RMGetMorphIndex  CharacterOrig "JawBkwd") as string +"] $Teeth_Dn.modifiers[#Morpher]["+ (RMGetMorphIndex  $Teeth_Dn "TJawBkwd") as string +"] \""+ (substituteString ((CharacterOrig.modifiers[#Morpher][(RMGetMorphIndex  CharacterOrig "JawBkwd")])as string) "SubAnim:" "")+"_" +"\" ")
				if Teeth_Flg[RMGetIndexOfElementInArray  Teeth "Teeth_DnWide"]==true do execute ("paramWire.connect $"+CharacterOrig.name+".modifiers[#Morpher]["+(RMGetMorphIndex  CharacterOrig "WIDE") as string +"] $Teeth_Dn.modifiers[#Morpher]["+ (RMGetMorphIndex  $Teeth_Dn "Teeth_DnWide") as string +"] \""+ (substituteString ((CharacterOrig.modifiers[#Morpher][(RMGetMorphIndex  CharacterOrig "WIDE")])as string) "SubAnim:" "")+"_" +"\" ")
		)
		if Unique_Flg[RMGetIndexOfElementInArray  Unique "Teeth_Up"] and Teeth_Flg[RMGetIndexOfElementInArray  Teeth "Teeth_UpWide"]==true do 
		(
			select $Teeth_Up
			if (RMMorpherExist $Teeth_Up==False) do
				(
					addmodifier  $Teeth_Up (Morpher())
					WM3_MC_BuildFromNode $Teeth_Up.modifiers["Morpher"]  1  $Teeth_UpWide
				)
			if Unique_Flg[RMGetIndexOfElementInArray  Unique "Teeth_UpWide"] do  execute ("paramWire.connect $"+CharacterOrig.name+".modifiers[#Morpher]["+(RMGetMorphIndex  CharacterOrig "WIDE") as string +"] $Teeth_Up.modifiers[#Morpher]["+ (RMGetMorphIndex  $Teeth_Up "Teeth_UpWide") as string +"] \""+ (substituteString ((CharacterOrig.modifiers[#Morpher][(RMGetMorphIndex  CharacterOrig "WIDE")])as string) "SubAnim:" "")+"_" +"\" ")
		)
	)


fn LinkM CharacterOrig Names Names_Flg Unique Unique_Flg=(
	select CharacterOrig
	if (RMMorpherExist CharacterOrig==False) do
		(
			addmodifier  CharacterOrig (Morpher())
			n=1
			for i in Names do
				(	if Names_Flg[RMGetIndexOfElementInArray  Names i]==true do 
						(print ("Set Morphers "+i  as string)
							WM3_MC_BuildFromNode CharacterOrig.modifiers["Morpher"]  n  (execute("$"+i))
						n=n+1;
							)
				)
		   if Unique_Flg[RMGetIndexOfElementInArray  Unique "Jaw_Half_Open"]==true do  
		   (
			WM3_AddProgressiveMorphNode CharacterOrig.modifiers["Morpher"] (RMGetMorphIndex  CharacterOrig "Jaw_Full_Open")  $Jaw_Half_Open
			WM3_SetProgressiveMorphWeight CharacterOrig.modifiers["Morpher"]  (RMGetMorphIndex  CharacterOrig "Jaw_Full_Open") $Jaw_Half_Open 50.0
			WM3_SetProgressiveMorphWeight CharacterOrig.modifiers["Morpher"]  (RMGetMorphIndex  CharacterOrig "Jaw_Full_Open") $Jaw_Full_Open 100.0
		   )
		   if Unique_Flg[RMGetIndexOfElementInArray  Unique "Reye_half_cls"]==true do  
		   (
			WM3_AddProgressiveMorphNode CharacterOrig.modifiers["Morpher"] (RMGetMorphIndex  CharacterOrig "Reye_cls")  $Reye_half_cls
			WM3_SetProgressiveMorphWeight CharacterOrig.modifiers["Morpher"]  (RMGetMorphIndex  CharacterOrig "Reye_cls") $Reye_half_cls 50.0
			WM3_SetProgressiveMorphWeight CharacterOrig.modifiers["Morpher"]  (RMGetMorphIndex  CharacterOrig "Reye_cls") $Reye_cls 100.0
		   )
		   if Unique_Flg[RMGetIndexOfElementInArray  Unique "Leye_half_cls"]==true do  
		   (
			WM3_AddProgressiveMorphNode CharacterOrig.modifiers["Morpher"] (RMGetMorphIndex  CharacterOrig "Leye_cls")  $Leye_half_cls
			WM3_SetProgressiveMorphWeight CharacterOrig.modifiers["Morpher"]  (RMGetMorphIndex  CharacterOrig "Leye_cls") $Leye_half_cls 50.0
			WM3_SetProgressiveMorphWeight CharacterOrig.modifiers["Morpher"]  (RMGetMorphIndex  CharacterOrig "Leye_cls") $Leye_cls 100.0
		   )
		)

    if Names_Flg[RMGetIndexOfElementInArray  Names "RBrowOut_Up"]==true do(  execute ("paramWire.connect $RBrowOut_Up_Dn_ctrl.pos.controller[#Z_Position] $"+CharacterOrig.name+".modifiers[#Morpher]["+ (RMGetMorphIndex  CharacterOrig "RBrowOut_Up")as string +"] \"if Z_Position>0 then Z_Position*100 else 0\" ") )--RBrowUp
    if Names_Flg[RMGetIndexOfElementInArray  Names "LBrowOut_Up"]==true do( execute ( "paramWire.connect $LBrowOut_Up_Dn_ctrl.pos.controller[#Z_Position] $"+CharacterOrig.name+".modifiers[#Morpher]["+ (RMGetMorphIndex  CharacterOrig "LBrowOut_Up") as string +"]\"if Z_Position>0 then Z_Position*100 else 0\" ")  )--LBrowUp
	if Names_Flg[RMGetIndexOfElementInArray  Names "LBrowOut_Dn"]==true do( execute ( "paramWire.connect $LBrowOut_Up_Dn_ctrl.pos.controller[#Z_Position] $"+CharacterOrig.name+".modifiers[#Morpher]["+ (RMGetMorphIndex  CharacterOrig "LBrowOut_Dn")as string +"]\"if Z_Position<0 then -Z_Position*100 else 0\" ")  )--LBrowDown
	if Names_Flg[RMGetIndexOfElementInArray  Names "RBrowOut_Dn"]==true do( execute ("paramWire.connect $RBrowOut_Up_Dn_ctrl.pos.controller[#Z_Position] $"+CharacterOrig.name+".modifiers[#Morpher]["+ (RMGetMorphIndex  CharacterOrig "RBrowOut_Dn")as string +"] \"if Z_Position<0 then -Z_Position*100 else 0\" ") )--RBrowDown

    if Names_Flg[RMGetIndexOfElementInArray  Names "RBrowIn_Up"]==true do( execute ("paramWire.connect $RBrowOut_Up_Dn_ctrl.pos.controller[#X_Position] $"+CharacterOrig.name+".modifiers[#Morpher]["+ (RMGetMorphIndex  CharacterOrig "RBrowIn_Up")as string +"] \"if X_Position>0 then X_Position*100 else 0\" ") )--RBrowUp
    if Names_Flg[RMGetIndexOfElementInArray  Names "RBrowIn_Dn"]==true do( execute ("paramWire.connect $RBrowOut_Up_Dn_ctrl.pos.controller[#X_Position] $"+CharacterOrig.name+".modifiers[#Morpher]["+ (RMGetMorphIndex  CharacterOrig "RBrowIn_Dn")as string +"] \"if X_Position<0 then -X_Position*100 else 0\" ") )--RBrowDown
	if Names_Flg[RMGetIndexOfElementInArray  Names "LBrowIn_Up"]==true do( execute( "paramWire.connect $LBrowOut_Up_Dn_ctrl.pos.controller[#X_Position] $"+CharacterOrig.name+".modifiers[#Morpher]["+ (RMGetMorphIndex  CharacterOrig "LBrowIn_Up") as string +"]\"if X_Position<0 then -X_Position*100 else 0\" ") )--LBrowUp	
	if Names_Flg[RMGetIndexOfElementInArray  Names "LBrowIn_Dn"]==true do(execute( "paramWire.connect $LBrowOut_Up_Dn_ctrl.pos.controller[#X_Position] $"+CharacterOrig.name+".modifiers[#Morpher]["+ (RMGetMorphIndex  CharacterOrig "LBrowIn_Dn")as string +"]\"if X_Position>0 then X_Position*100 else 0\" ") ) --LBrowDown
	
	
	if Names_Flg[RMGetIndexOfElementInArray  Names "Browsqueeze"]==true do(execute ("paramWire.connect $Browsqueeze_ctrl.pos.controller[#X_Position] $"+CharacterOrig.name+".modifiers[#Morpher]["+ (RMGetMorphIndex  CharacterOrig "Browsqueeze")as string +"] \"if X_Position>-50 then (X_position*100) else -50\""))--Browsqueeze
	
	if Names_Flg[RMGetIndexOfElementInArray  Names "UprLip_Up"]==true do(execute ("paramWire.connect $UprLip_Up_Dn_ctrl.pos.controller[#Z_Position] $"+CharacterOrig.name+".modifiers[#Morpher]["+ (RMGetMorphIndex  CharacterOrig "UprLip_Up")as string +"] \"if Z_Position>0 then (Z_position*100) else 0\""))--UperLip
	if Names_Flg[RMGetIndexOfElementInArray  Names "UprLip_Dn"]==true do(execute ("paramWire.connect $UprLip_Up_Dn_ctrl.pos.controller[#Z_Position] $"+CharacterOrig.name+".modifiers[#Morpher]["+ (RMGetMorphIndex  CharacterOrig "UprLip_Dn")as string +"] \"if Z_Position<0 then (-Z_position*100) else 0\""))--LowerLip


	if Names_Flg[RMGetIndexOfElementInArray  Names "LSmile"]==true do(execute ("paramWire.connect $Lsquint_ctrl.pos.controller[#Z_Position] $"+CharacterOrig.name+".modifiers[#Morpher]["+ (RMGetMorphIndex  CharacterOrig "LSmile")as string +"] \"if Z_Position>0 then (Z_position*100) else 0\""))--LSmile
	if Names_Flg[RMGetIndexOfElementInArray  Names "RSmile"]==true do(execute ("paramWire.connect $Rsquint_ctrl.pos.controller[#Z_Position] $"+CharacterOrig.name+".modifiers[#Morpher]["+ (RMGetMorphIndex  CharacterOrig "RSmile")as string +"] \"if Z_Position>0 then (Z_position*100) else 0\""))--RSmile
	if Names_Flg[RMGetIndexOfElementInArray  Names "LFrown"]==true do(execute ("paramWire.connect $Lsquint_ctrl.pos.controller[#Z_Position] $"+CharacterOrig.name+".modifiers[#Morpher]["+ (RMGetMorphIndex  CharacterOrig "LFrown")as string +"] \"if Z_Position<0 then (-Z_position*100) else 0\""))--LFrown
	if Names_Flg[RMGetIndexOfElementInArray  Names "RFrown"]==true do(execute ("paramWire.connect $Rsquint_ctrl.pos.controller[#Z_Position] $"+CharacterOrig.name+".modifiers[#Morpher]["+ (RMGetMorphIndex  CharacterOrig "RFrown")as string +"] \"if Z_Position<0 then (-Z_position*100) else 0\""))--RFrown
	
	if Names_Flg[RMGetIndexOfElementInArray  Names "LSquint"]==true do(execute ("paramWire.connect $Lsquint_ctrl.pos.controller[#X_Position] $"+CharacterOrig.name+".modifiers[#Morpher]["+ (RMGetMorphIndex  CharacterOrig "LSquint")as string +"] \"X_Position*100\" "))--Left Squint
	if Names_Flg[RMGetIndexOfElementInArray  Names "RSquint"]==true do(execute ("paramWire.connect $Rsquint_ctrl.pos.controller[#X_Position] $"+CharacterOrig.name+".modifiers[#Morpher]["+ (RMGetMorphIndex  CharacterOrig "RSquint")as string +"] \"-X_Position*100\" "))--Right Squint
		

	if Names_Flg[RMGetIndexOfElementInArray  Names "WIDE"]==true do(execute ("paramWire.connect $Jaw_open_ctrl.pos.controller[#X_Position] $"+CharacterOrig.name+".modifiers[#Morpher]["+ (RMGetMorphIndex  CharacterOrig "WIDE")as string +"] \"if X_Position > 0 then X_Position*100 else 0 \""))--JawWide
	if Names_Flg[RMGetIndexOfElementInArray  Names "Narrow"]==true do(execute ("paramWire.connect $Jaw_open_ctrl.pos.controller[#X_Position] $"+CharacterOrig.name+".modifiers[#Morpher]["+ (RMGetMorphIndex  CharacterOrig "Narrow")as string +"] \"if X_Position < 0 then -X_Position*100 else 0\""))--Narrow

	if Names_Flg[RMGetIndexOfElementInArray  Names "Reye_cls"]==true do(execute ("paramWire.connect $Reye_cls_ctrl.pos.controller[#Z_Position] $"+CharacterOrig.name+".modifiers[#Morpher]["+ (RMGetMorphIndex  CharacterOrig "Reye_cls")as string +"] \"if Z_Position < 0 then -Z_Position*100 else 0 \""))--ReyeClose
	if Names_Flg[RMGetIndexOfElementInArray  Names "Leye_cls"]==true do(execute ("paramWire.connect $Leye_cls_ctrl.pos.controller[#Z_Position] $"+CharacterOrig.name+".modifiers[#Morpher]["+ (RMGetMorphIndex  CharacterOrig "Leye_cls")as string +"] \"if Z_Position < 0 then -Z_Position*100 else 0\""))--LeyeClose

	if Names_Flg[RMGetIndexOfElementInArray  Names "Jaw_Full_Open"]==true do(execute ("paramWire.connect $Jaw_open_ctrl.pos.controller[#Z_Position] $"+CharacterOrig.name+".modifiers[#Morpher]["+ (RMGetMorphIndex  CharacterOrig "Jaw_Full_Open")as string +"] \"if Z_Position < 0 then -Z_Position*100 else 0 \""))--JawOpen
	if Names_Flg[RMGetIndexOfElementInArray  Names "JawClosed"]==true do(execute ("paramWire.connect $Jaw_open_ctrl.pos.controller[#Z_Position] $"+CharacterOrig.name+".modifiers[#Morpher]["+ (RMGetMorphIndex  CharacterOrig "JawClosed")as string +"] \"if Z_Position > 0 then Z_Position*100 else 0 \""))--JawClosed

	if Names_Flg[RMGetIndexOfElementInArray  Names "JawFwd"]==true do(execute ("paramWire.connect $Jaw_Fwd_ctrl.pos.controller[#Z_Position] $"+CharacterOrig.name+".modifiers[#Morpher]["+ (RMGetMorphIndex  CharacterOrig "JawFwd")as string +"] \"if Z_Position > 0 then Z_Position*100 else 0\""))--JawFwd
	if Names_Flg[RMGetIndexOfElementInArray  Names "JawBkwd"]==true do(execute ("paramWire.connect $Jaw_Fwd_ctrl.pos.controller[#Z_Position] $"+CharacterOrig.name+".modifiers[#Morpher]["+ (RMGetMorphIndex  CharacterOrig "JawBkwd")as string +"] \"if Z_Position < 0 then -Z_Position*100 else 0\""))--JawBackwards

	if Names_Flg[RMGetIndexOfElementInArray  Names "JawLeft"]==true do(execute ("paramWire.connect $Jaw_Fwd_ctrl.pos.controller[#X_Position] $"+CharacterOrig.name+".modifiers[#Morpher]["+ (RMGetMorphIndex  CharacterOrig "JawLeft")as string +"] \"if X_Position > 0 then X_Position*100 else 0\""))--JawLeft
	if Names_Flg[RMGetIndexOfElementInArray  Names "JawRight"]==true do(execute ("paramWire.connect $Jaw_Fwd_ctrl.pos.controller[#X_Position] $"+CharacterOrig.name+".modifiers[#Morpher]["+ (RMGetMorphIndex  CharacterOrig "JawRight")as string +"] \"if X_Position < 0 then -X_Position*100 else 0\""))--JawRight
	
	if Names_Flg[RMGetIndexOfElementInArray  Names "eye_roll_Rght"]==true do(
	CharacterOrig.modifiers[#Morpher][(RMGetMorphIndex  CharacterOrig "eye_roll_Rght")].controller=float_script()
	(CharacterOrig.modifiers[#Morpher][(RMGetMorphIndex  CharacterOrig "eye_roll_Rght")].controller).AddTarget "OjoMain"  $Ojo_Right_Ctrl.position.z_position.controller
	(CharacterOrig.modifiers[#Morpher][(RMGetMorphIndex  CharacterOrig "eye_roll_Rght")].controller).AddTarget "OjoNorm"  $OjoRectangle.position.z_position.controller
	(CharacterOrig.modifiers[#Morpher][(RMGetMorphIndex  CharacterOrig "eye_roll_Rght")].controller).AddTarget "Multip"  $AutoEyeLids_Cntrl.position.z_position.controller
	(CharacterOrig.modifiers[#Morpher][(RMGetMorphIndex  CharacterOrig "eye_roll_Rght")].controller).script="if (OjoNorm+OjoMain) < 0 then \n resultado=-(OjoNorm+OjoMain)*100*Multip \n else resultado=0 \n resultado "
	)
	if Names_Flg[RMGetIndexOfElementInArray  Names "eye_roll_lf"]==true do(
	CharacterOrig.modifiers[#Morpher][(RMGetMorphIndex  CharacterOrig "eye_roll_lf")].controller=float_script()
	(CharacterOrig.modifiers[#Morpher][(RMGetMorphIndex  CharacterOrig "eye_roll_lf")].controller).AddTarget "OjoMain"  $Ojo_Left_Ctrl.position.z_position.controller
	(CharacterOrig.modifiers[#Morpher][(RMGetMorphIndex  CharacterOrig "eye_roll_lf")].controller).AddTarget "OjoNorm"  $OjoRectangle.position.z_position.controller
	(CharacterOrig.modifiers[#Morpher][(RMGetMorphIndex  CharacterOrig "eye_roll_lf")].controller).AddTarget "Multip"  $AutoEyeLids_Cntrl.position.z_position.controller
	(CharacterOrig.modifiers[#Morpher][(RMGetMorphIndex  CharacterOrig "eye_roll_lf")].controller).script="if (OjoNorm+OjoMain) < 0 then \n resultado=-(OjoNorm+OjoMain)*100*Multip \n else resultado=0 \n resultado"
	)
	
	--execute ("paramWire.connect $Ojo_Right_Ctrl.pos.controller[#Z_Position] $"+CharacterOrig.name+".modifiers[#Morpher]["+ (RMGetMorphIndex  CharacterOrig "eye_roll_Rght")as string +"] \"if Z_Position < 0 then -Z_Position*100 else 0\"")--EyeRollRight
	--execute ("paramWire.connect $Ojo_Left_Ctrl.pos.controller[#Z_Position] $"+CharacterOrig.name+".modifiers[#Morpher]["+ (RMGetMorphIndex  CharacterOrig "eye_roll_lf")as string +"] \"if Z_Position < 0 then -Z_Position*100 else 0\"")--EyeRollRight
	--paramWire.connect $Jaw_open_ctrl.pos.controller[#Z_Position] $Point004.rotation.controller[#X_Rotation] "degtorad(if Z_position <-1 then 40 else( if Z_position>0 then 0 else -Z_Position*40))"
	--paramWire.connect $Jaw_open_ctrl.pos.controller[#Z_Position] $JawBone.rotation.controller[#Z_Rotation] "degtorad(if Z_position <-1 then -40 else( if Z_position>0 then 0 else Z_Position*40))"
	--paramWire.connect $Jaw_Fwd_ctrl.pos.controller[#Z_Position] $JawBone.position.controller[#X_Position] "Z_Position"
	--paramWire.connect $Jaw_Fwd_ctrl.pos.controller[#X_Position] $JawBone.rotation.controller[#Y_rotation] "X_Position*40"
)

fn SetupEyes =
(
	if ((in objects $Leye!=undefined) and (in objects $Reye!=undefined)) then 
	(
		point name:"ReyeOrientacion" size: 1
		point name:"ReyeBase" size: 1
		point name:"ReyeLookAt" size: 1
		point name:"ReyePointLookAt" size: 2

		point name:"LeyeOrientacion" size: 1
		point name:"LeyeBase" size: 1
		point name:"LeyeLookAt" size: 1
		point name:"LeyePointLookAt" size: 2

		point name:"eyeOrientation" size: 1



		/***********LeftEye Config********/	
		$LeyeBase.position=$Leye.position;
		$LeyeOrientacion.position=$Leye.position;
		$LeyeLookAt.position=$Leye.position;
		$LeyePointLookAt.position=$Leye.position;

		move $LeyePointLookAt [0, -2, 0]

		$LeyeBase.parent=$LEye.parent;
		$LeyeLookAt.parent=$LeyeBase
		$LeyeOrientacion.parent=$LeyeLookAt;


		$LeyeLookAt.rotation.controller=LookAt_Constraint();
		$LeyeLookAt.rotation.controller.appendTarget $LeyePointLookAt 100.0
		$LeyeLookAt.rotation.controller.upnode_world = off
		$LeyeLookAt.rotation.controller.pickUpNode = $eyeOrientation
		$LeyeLookAt.rotation.controller.upnode_ctrl = 1
		$LeyeLookAt.rotation.controller.lookat_vector_length = 5

		$LeyeOrientacion.rotation.y_rotation.controller=float_script()
		($LeyeOrientacion.rotation.y_rotation.controller).AddTarget "OjoMain"  $Ojo_Left_Ctrl.position.z_position.controller
		($LeyeOrientacion.rotation.y_rotation.controller).AddTarget "OjoNorm"  $OjoRectangle.position.z_position.controller
		($LeyeOrientacion.rotation.y_rotation.controller).script="((-OjoNorm*4-OjoMain*4)/2)"
		$LeyeOrientacion.rotation.z_rotation.controller=float_script()
		($LeyeOrientacion.rotation.z_rotation.controller).AddTarget "OjoMain"  $Ojo_Left_Ctrl.position.x_position.controller
		($LeyeOrientacion.rotation.z_rotation.controller).AddTarget "OjoNorm"  $OjoRectangle.position.x_position.controller
		($LeyeOrientacion.rotation.z_rotation.controller).script="((OjoNorm*4+OjoMain*4)/2)"

		--paramWire.connect $Ojo_Left_Ctrl.pos.controller[#Z_Position] $LeyeOrientacion.rotation.controller[#Y_Rotation] "-Z_Position/2"
		--paramWire.connect $Ojo_Left_Ctrl.pos.controller[#X_Position] $LeyeOrientacion.rotation.controller[#Z_Rotation] "X_Position/2"

		/***********RightEye Config********/	
		$ReyeBase.position=$Reye.position;
		$ReyeOrientacion.position=$Reye.position;
		$ReyeLookAt.position=$Reye.position;
		$ReyePointLookAt.position=$Reye.position;

		move $ReyePointLookAt [0, -2, 0]

		$ReyeBase.parent=$REye.parent;
		$ReyeLookAt.parent=$ReyeBase
		$ReyeOrientacion.parent=$ReyeLookAt;


		$ReyeLookAt.rotation.controller=LookAt_Constraint();
		$ReyeLookAt.rotation.controller.appendTarget $ReyePointLookAt 100.0
		$ReyeLookAt.rotation.controller.upnode_world = off
		$ReyeLookAt.rotation.controller.pickUpNode = $eyeOrientation
		$ReyeLookAt.rotation.controller.upnode_ctrl = 1
		$ReyeLookAt.rotation.controller.lookat_vector_length = 5


		$ReyeOrientacion.rotation.y_rotation.controller=float_script()

		($ReyeOrientacion.rotation.y_rotation.controller).AddTarget "OjoMain"  $Ojo_Right_Ctrl.position.z_position.controller
		($ReyeOrientacion.rotation.y_rotation.controller).AddTarget "OjoNorm"  $OjoRectangle.position.z_position.controller
		($ReyeOrientacion.rotation.y_rotation.controller).script="((-OjoNorm*4-OjoMain*4)/2)"
		$ReyeOrientacion.rotation.z_rotation.controller=float_script()
		($ReyeOrientacion.rotation.z_rotation.controller).AddTarget "OjoMain"  $Ojo_Right_Ctrl.position.x_position.controller
		($ReyeOrientacion.rotation.z_rotation.controller).AddTarget "OjoNorm"  $OjoRectangle.position.x_position.controller
		($ReyeOrientacion.rotation.z_rotation.controller).script="((OjoNorm*4+OjoMain*4)/2)"

		--paramWire.connect $Ojo_Right_Ctrl.pos.controller[#Z_Position] $ReyeOrientacion.rotation.controller[#Y_Rotation] "-Z_Position/2"
		--paramWire.connect $Ojo_Right_Ctrl.pos.controller[#X_Position] $ReyeOrientacion.rotation.controller[#Z_Rotation] "X_Position/2"
		/****************************************************/

		$eyeOrientation.position.x = ($Leye.position.x + $Reye.position.x)/2;
		$eyeOrientation.position.y = ($Leye.position.y + $Reye.position.y)/2;
		$eyeOrientation.position.z = ($Leye.position.z + $Reye.position.z)/2;

		move $eyeOrientation [0, 0, 5]

		$eyeOrientation.parent=$LEye.parent

		$LeyeBase.parent=$LEye.parent;
		$LEye.parent=$LeyeOrientacion;
			
		$ReyeBase.parent=$REye.parent;
		$OjosLookAt.parent=$REye.parent;
		$REye.parent=$ReyeOrientacion;
		$LeyePointLookAt.parent=$OjosLookAt_L;
		$ReyePointLookAt.parent=$OjosLookAt_R;
	)
	else (
		   return "No existen los objetos LEye y REye"
		   )
)

