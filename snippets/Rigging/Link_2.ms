/*****************************************************/
/*Funcion que obtiene el indice en el arreglo de la cadena proporcionada
   en caso de que no exista el resultado regresado es  0*/
/*****************************************************/
fn GetArrayNum arreglo cadena =(
	f=0;
	n=0;
	for i in arreglo do 
	(
		n=n+1;
		if i==cadena do 
			f=n;
	)
	return f
)
/*****************************************************/
fn LinkTonge CharacterOrig Names=(
	select $Tonge
	if (existeMorpher $Tonge==False) do
		(
			addmodifier  $Tonge (Morpher())
		
			n=1
	for i in Names do
			(		 
			WM3_MC_BuildFromNode $Tonge.modifiers["Morpher"]  n  (execute("$"+i))
			n=n+1;
			)
			WM3_AddProgressiveMorphNode $Tonge.modifiers["Morpher"] (NumMorpher $Tonge "Jaw_Full_Open")  $TongeJaw_Half_Open
			WM3_SetProgressiveMorphWeight $Tonge.modifiers["Morpher"]  (NumMorpher $Tonge "Jaw_Full_Open") $TongeJaw_Half_Open 50.0
			WM3_SetProgressiveMorphWeight $Tonge.modifiers["Morpher"]  (NumMorpher $Tonge "Jaw_Full_Open") $TongeJaw_Full_Open 100.0
		)
			
			execute ("paramWire.connect $"+CharacterOrig.name+".modifiers[#Morpher]["+(NumMorpher CharacterOrig "JawLeft") as string +"] $Tonge.modifiers[#Morpher]["+ (NumMorpher $Tonge "TongeJawLeft") as string +"] \""+ (substituteString ((CharacterOrig.modifiers[#Morpher][(NumMorpher CharacterOrig "JawLeft")])as string) "SubAnim:" "")+"_" +"\" ")
			execute ("paramWire.connect $"+CharacterOrig.name+".modifiers[#Morpher]["+(NumMorpher CharacterOrig "JawRight") as string +"] $Tonge.modifiers[#Morpher]["+ (NumMorpher $Tonge "TongeJawRight") as string +"] \""+ (substituteString ((CharacterOrig.modifiers[#Morpher][(NumMorpher CharacterOrig "JawRight")])as string) "SubAnim:" "")+"_" +"\" ")
			execute ("paramWire.connect $"+CharacterOrig.name+".modifiers[#Morpher]["+(NumMorpher CharacterOrig "Jaw_Full_Open") as string +"] $Tonge.modifiers[#Morpher]["+ (NumMorpher $Tonge "TongeJaw_Full_Open") as string +"] \""+ (substituteString ((CharacterOrig.modifiers[#Morpher][(NumMorpher CharacterOrig "Jaw_Full_Open")])as string) "SubAnim:" "")+"_" +"\" ")
			execute ("paramWire.connect $"+CharacterOrig.name+".modifiers[#Morpher]["+(NumMorpher CharacterOrig "JawFwd") as string +"] $Tonge.modifiers[#Morpher]["+ (NumMorpher $Tonge "TongeJawFwd") as string +"] \""+ (substituteString ((CharacterOrig.modifiers[#Morpher][(NumMorpher CharacterOrig "JawFwd")])as string) "SubAnim:" "")+"_" +"\" ")
			execute ("paramWire.connect $"+CharacterOrig.name+".modifiers[#Morpher]["+(NumMorpher CharacterOrig "JawBkwd") as string +"] $Tonge.modifiers[#Morpher]["+ (NumMorpher $Tonge "TongeJawBkwd") as string +"] \""+ (substituteString ((CharacterOrig.modifiers[#Morpher][(NumMorpher CharacterOrig "JawBkwd")])as string) "SubAnim:" "")+"_" +"\" ")
			execute ("paramWire.connect $"+CharacterOrig.name+".modifiers[#Morpher]["+(NumMorpher CharacterOrig "WIDE") as string +"] $Tonge.modifiers[#Morpher]["+ (NumMorpher $Tonge "TongeWide") as string +"] \""+ (substituteString ((CharacterOrig.modifiers[#Morpher][(NumMorpher CharacterOrig "WIDE")])as string) "SubAnim:" "")+"_" +"\" ")
	)
	
/**************
/***********************************************************/
fn LinkTeeth CharacterOrig Teeth  Teeth_Flg Unique Unique_Flg=(
		if Unique_Flg[GetArrayNum Unique "Teeth_Dn"] do 
		(
			select $Teeth_Dn
			if (existeMorpher $Teeth_Dn==False) do
				(
					addmodifier  $Teeth_Dn (Morpher())
				n=1
				for i in Teeth do
					(		 
					if Teeth_Flg [GetArrayNum Teeth i]==true do 
						(
						WM3_MC_BuildFromNode $Teeth_Dn.modifiers["Morpher"]  n  (execute("$"+i))
						n=n+1;
						)
					)
					
				if Teeth_Flg[GetArrayNum Teeth "TJaw_Half_Open"]==true do WM3_AddProgressiveMorphNode $Teeth_Dn.modifiers["Morpher"] (NumMorpher $Teeth_Dn "TJaw_Full_Open")  $TJaw_Half_Open
				if Teeth_Flg[GetArrayNum Teeth "TJaw_Half_Open"]==true do WM3_SetProgressiveMorphWeight $Teeth_Dn.modifiers["Morpher"]  (NumMorpher $Teeth_Dn "TJaw_Full_Open") $TJaw_Half_Open 50.0
				if Teeth_Flg[GetArrayNum Teeth "TJaw_Full_Open"]==true do WM3_SetProgressiveMorphWeight $Teeth_Dn.modifiers["Morpher"]  (NumMorpher $Teeth_Dn "TJaw_Full_Open") $TJaw_Full_Open 100.0
				)
				if Teeth_Flg[GetArrayNum Teeth "TJawLeft"]==true do   execute ("paramWire.connect $"+CharacterOrig.name+".modifiers[#Morpher]["+(NumMorpher CharacterOrig "JawLeft") as string +"] $Teeth_Dn.modifiers[#Morpher]["+ (NumMorpher $Teeth_Dn "TJawLeft") as string +"] \""+ (substituteString ((CharacterOrig.modifiers[#Morpher][(NumMorpher CharacterOrig "JawLeft")])as string) "SubAnim:" "")+"_" +"\" ")
				if Teeth_Flg[GetArrayNum Teeth  "TJawRight"]==true do execute ("paramWire.connect $"+CharacterOrig.name+".modifiers[#Morpher]["+(NumMorpher CharacterOrig "JawRight") as string +"] $Teeth_Dn.modifiers[#Morpher]["+ (NumMorpher $Teeth_Dn "TJawRight") as string +"] \""+ (substituteString ((CharacterOrig.modifiers[#Morpher][(NumMorpher CharacterOrig "JawRight")])as string) "SubAnim:" "")+"_" +"\" ")
				if Teeth_Flg[GetArrayNum Teeth "TJaw_Full_Open"]==true do execute ("paramWire.connect $"+CharacterOrig.name+".modifiers[#Morpher]["+(NumMorpher CharacterOrig "Jaw_Full_Open") as string +"] $Teeth_Dn.modifiers[#Morpher]["+ (NumMorpher $Teeth_Dn "TJaw_Full_Open") as string +"] \""+ (substituteString ((CharacterOrig.modifiers[#Morpher][(NumMorpher CharacterOrig "Jaw_Full_Open")])as string) "SubAnim:" "")+"_" +"\" ")
				if Teeth_Flg[GetArrayNum Teeth "TJawFwd"]==true do execute ("paramWire.connect $"+CharacterOrig.name+".modifiers[#Morpher]["+(NumMorpher CharacterOrig "JawFwd") as string +"] $Teeth_Dn.modifiers[#Morpher]["+ (NumMorpher $Teeth_Dn "TJawFwd") as string +"] \""+ (substituteString ((CharacterOrig.modifiers[#Morpher][(NumMorpher CharacterOrig "JawFwd")])as string) "SubAnim:" "")+"_" +"\" ")
				if Teeth_Flg[GetArrayNum Teeth "TJawBkwd"]==true do execute ("paramWire.connect $"+CharacterOrig.name+".modifiers[#Morpher]["+(NumMorpher CharacterOrig "JawBkwd") as string +"] $Teeth_Dn.modifiers[#Morpher]["+ (NumMorpher $Teeth_Dn "TJawBkwd") as string +"] \""+ (substituteString ((CharacterOrig.modifiers[#Morpher][(NumMorpher CharacterOrig "JawBkwd")])as string) "SubAnim:" "")+"_" +"\" ")
				if Teeth_Flg[GetArrayNum Teeth "Teeth_DnWide"]==true do execute ("paramWire.connect $"+CharacterOrig.name+".modifiers[#Morpher]["+(NumMorpher CharacterOrig "WIDE") as string +"] $Teeth_Dn.modifiers[#Morpher]["+ (NumMorpher $Teeth_Dn "Teeth_DnWide") as string +"] \""+ (substituteString ((CharacterOrig.modifiers[#Morpher][(NumMorpher CharacterOrig "WIDE")])as string) "SubAnim:" "")+"_" +"\" ")
		)
		if Unique_Flg[GetArrayNum Unique "Teeth_Up"] and Teeth_Flg[GetArrayNum Teeth "Teeth_UpWide"]==true do 
		(
			select $Teeth_Up
			if (existeMorpher $Teeth_Up==False) do
				(
					addmodifier  $Teeth_Up (Morpher())
					WM3_MC_BuildFromNode $Teeth_Up.modifiers["Morpher"]  1  $Teeth_UpWide
				)
			if Unique_Flg[GetArrayNum Unique "Teeth_UpWide"] do  execute ("paramWire.connect $"+CharacterOrig.name+".modifiers[#Morpher]["+(NumMorpher CharacterOrig "WIDE") as string +"] $Teeth_Up.modifiers[#Morpher]["+ (NumMorpher $Teeth_Up "Teeth_UpWide") as string +"] \""+ (substituteString ((CharacterOrig.modifiers[#Morpher][(NumMorpher CharacterOrig "WIDE")])as string) "SubAnim:" "")+"_" +"\" ")
		)
	)
	
/**************
Esta Funcion acepta un objeto obj que tiene un morpher y una cadena que es el nombre del morpher, 
La funcion regresa el numero del canal donde se encuentra este Morpher
************************/
fn NumMorpher obj MorphName=
(
retVal=0;
i=1;
while (i<100) do 
	(ChannelName=WM3_MC_GetName obj.modifiers["Morpher"] i
	if ChannelName ==MorphName do
		(
		retVal=i
		i=100;
		)
	if ChannelName=="- empty -" do
		i=100;
	i=i+1;
	)
return retVal
)
/**********************
Funcion regresa True  Si existe un modificador Morpher en el objeto
***********************/
fn existeMorpher a=
	(
		if a.modifiers["Morpher"]!=undefined then
				return true
		else 
				return false;
	)
/**************************************************/
fn LinkM CharacterOrig Names Names_Flg Unique Unique_Flg=(
	select CharacterOrig
	if (existeMorpher CharacterOrig==False) do
		(
			addmodifier  CharacterOrig (Morpher())
			n=1
			for i in Names do
				(	if Names_Flg[GetArrayNum Names i]==true do 
						(print ("Pone Morphers"+i  as string)
							WM3_MC_BuildFromNode CharacterOrig.modifiers["Morpher"]  n  (execute("$"+i))
						n=n+1;
							)
				)
		   if Unique_Flg[GetArrayNum Unique "Jaw_Half_Open"]==true do  
		   (
			WM3_AddProgressiveMorphNode CharacterOrig.modifiers["Morpher"] (NumMorpher CharacterOrig "Jaw_Full_Open")  $Jaw_Half_Open
			WM3_SetProgressiveMorphWeight CharacterOrig.modifiers["Morpher"]  (NumMorpher CharacterOrig "Jaw_Full_Open") $Jaw_Half_Open 50.0
			WM3_SetProgressiveMorphWeight CharacterOrig.modifiers["Morpher"]  (NumMorpher CharacterOrig "Jaw_Full_Open") $Jaw_Full_Open 100.0
		   )
		   if Unique_Flg[GetArrayNum Unique "Reye_half_cls"]==true do  
		   (
			WM3_AddProgressiveMorphNode CharacterOrig.modifiers["Morpher"] (NumMorpher CharacterOrig "Reye_cls")  $Reye_half_cls
			WM3_SetProgressiveMorphWeight CharacterOrig.modifiers["Morpher"]  (NumMorpher CharacterOrig "Reye_cls") $Reye_half_cls 50.0
			WM3_SetProgressiveMorphWeight CharacterOrig.modifiers["Morpher"]  (NumMorpher CharacterOrig "Reye_cls") $Reye_cls 100.0
		   )
		   if Unique_Flg[GetArrayNum Unique "Leye_half_cls"]==true do  
		   (
			WM3_AddProgressiveMorphNode CharacterOrig.modifiers["Morpher"] (NumMorpher CharacterOrig "Leye_cls")  $Leye_half_cls
			WM3_SetProgressiveMorphWeight CharacterOrig.modifiers["Morpher"]  (NumMorpher CharacterOrig "Leye_cls") $Leye_half_cls 50.0
			WM3_SetProgressiveMorphWeight CharacterOrig.modifiers["Morpher"]  (NumMorpher CharacterOrig "Leye_cls") $Leye_cls 100.0
		   )
		)

    if Names_Flg[GetArrayNum Names "RBrowOut_Up"]==true do(  execute ("paramWire.connect $RBrowOut_Up_Dn_ctrl.pos.controller[#Z_Position] $"+CharacterOrig.name+".modifiers[#Morpher]["+ (NumMorpher CharacterOrig "RBrowOut_Up")as string +"] \"if Z_Position>0 then Z_Position*100 else 0\" ") )--RBrowUp
    if Names_Flg[GetArrayNum Names "LBrowOut_Up"]==true do( execute ( "paramWire.connect $LBrowOut_Up_Dn_ctrl.pos.controller[#Z_Position] $"+CharacterOrig.name+".modifiers[#Morpher]["+ (NumMorpher CharacterOrig "LBrowOut_Up") as string +"]\"if Z_Position>0 then Z_Position*100 else 0\" ")  )--LBrowUp
	if Names_Flg[GetArrayNum Names "LBrowOut_Dn"]==true do( execute ( "paramWire.connect $LBrowOut_Up_Dn_ctrl.pos.controller[#Z_Position] $"+CharacterOrig.name+".modifiers[#Morpher]["+ (NumMorpher CharacterOrig "LBrowOut_Dn")as string +"]\"if Z_Position<0 then -Z_Position*100 else 0\" ")  )--LBrowDown
	if Names_Flg[GetArrayNum Names "RBrowOut_Dn"]==true do( execute ("paramWire.connect $RBrowOut_Up_Dn_ctrl.pos.controller[#Z_Position] $"+CharacterOrig.name+".modifiers[#Morpher]["+ (NumMorpher CharacterOrig "RBrowOut_Dn")as string +"] \"if Z_Position<0 then -Z_Position*100 else 0\" ") )--RBrowDown

    if Names_Flg[GetArrayNum Names "RBrowIn_Up"]==true do( execute ("paramWire.connect $RBrowOut_Up_Dn_ctrl.pos.controller[#X_Position] $"+CharacterOrig.name+".modifiers[#Morpher]["+ (NumMorpher CharacterOrig "RBrowIn_Up")as string +"] \"if X_Position>0 then X_Position*100 else 0\" ") )--RBrowUp
    if Names_Flg[GetArrayNum Names "RBrowIn_Dn"]==true do( execute ("paramWire.connect $RBrowOut_Up_Dn_ctrl.pos.controller[#X_Position] $"+CharacterOrig.name+".modifiers[#Morpher]["+ (NumMorpher CharacterOrig "RBrowIn_Dn")as string +"] \"if X_Position<0 then -X_Position*100 else 0\" ") )--RBrowDown
	if Names_Flg[GetArrayNum Names "LBrowIn_Up"]==true do( execute( "paramWire.connect $LBrowOut_Up_Dn_ctrl.pos.controller[#X_Position] $"+CharacterOrig.name+".modifiers[#Morpher]["+ (NumMorpher CharacterOrig "LBrowIn_Up") as string +"]\"if X_Position<0 then -X_Position*100 else 0\" ") )--LBrowUp	
	if Names_Flg[GetArrayNum Names "LBrowIn_Dn"]==true do(execute( "paramWire.connect $LBrowOut_Up_Dn_ctrl.pos.controller[#X_Position] $"+CharacterOrig.name+".modifiers[#Morpher]["+ (NumMorpher CharacterOrig "LBrowIn_Dn")as string +"]\"if X_Position>0 then X_Position*100 else 0\" ") ) --LBrowDown
	
	
	if Names_Flg[GetArrayNum Names "Browsqueeze"]==true do(execute ("paramWire.connect $Browsqueeze_ctrl.pos.controller[#X_Position] $"+CharacterOrig.name+".modifiers[#Morpher]["+ (NumMorpher CharacterOrig "Browsqueeze")as string +"] \"if X_Position>-50 then (X_position*100) else -50\""))--Browsqueeze
	
	if Names_Flg[GetArrayNum Names "UprLip_Up"]==true do(execute ("paramWire.connect $UprLip_Up_Dn_ctrl.pos.controller[#Z_Position] $"+CharacterOrig.name+".modifiers[#Morpher]["+ (NumMorpher CharacterOrig "UprLip_Up")as string +"] \"if Z_Position>0 then (Z_position*100) else 0\""))--UperLip
	if Names_Flg[GetArrayNum Names "UprLip_Dn"]==true do(execute ("paramWire.connect $UprLip_Up_Dn_ctrl.pos.controller[#Z_Position] $"+CharacterOrig.name+".modifiers[#Morpher]["+ (NumMorpher CharacterOrig "UprLip_Dn")as string +"] \"if Z_Position<0 then (-Z_position*100) else 0\""))--LowerLip


	if Names_Flg[GetArrayNum Names "LSmile"]==true do(execute ("paramWire.connect $Lsquint_ctrl.pos.controller[#Z_Position] $"+CharacterOrig.name+".modifiers[#Morpher]["+ (NumMorpher CharacterOrig "LSmile")as string +"] \"if Z_Position>0 then (Z_position*100) else 0\""))--LSmile
	if Names_Flg[GetArrayNum Names "RSmile"]==true do(execute ("paramWire.connect $Rsquint_ctrl.pos.controller[#Z_Position] $"+CharacterOrig.name+".modifiers[#Morpher]["+ (NumMorpher CharacterOrig "RSmile")as string +"] \"if Z_Position>0 then (Z_position*100) else 0\""))--RSmile
	if Names_Flg[GetArrayNum Names "LFrown"]==true do(execute ("paramWire.connect $Lsquint_ctrl.pos.controller[#Z_Position] $"+CharacterOrig.name+".modifiers[#Morpher]["+ (NumMorpher CharacterOrig "LFrown")as string +"] \"if Z_Position<0 then (-Z_position*100) else 0\""))--LFrown
	if Names_Flg[GetArrayNum Names "RFrown"]==true do(execute ("paramWire.connect $Rsquint_ctrl.pos.controller[#Z_Position] $"+CharacterOrig.name+".modifiers[#Morpher]["+ (NumMorpher CharacterOrig "RFrown")as string +"] \"if Z_Position<0 then (-Z_position*100) else 0\""))--RFrown
	
	if Names_Flg[GetArrayNum Names "LSquint"]==true do(execute ("paramWire.connect $Lsquint_ctrl.pos.controller[#X_Position] $"+CharacterOrig.name+".modifiers[#Morpher]["+ (NumMorpher CharacterOrig "LSquint")as string +"] \"X_Position*100\" "))--Left Squint
	if Names_Flg[GetArrayNum Names "RSquint"]==true do(execute ("paramWire.connect $Rsquint_ctrl.pos.controller[#X_Position] $"+CharacterOrig.name+".modifiers[#Morpher]["+ (NumMorpher CharacterOrig "RSquint")as string +"] \"-X_Position*100\" "))--Right Squint
		

	if Names_Flg[GetArrayNum Names "WIDE"]==true do(execute ("paramWire.connect $Jaw_open_ctrl.pos.controller[#X_Position] $"+CharacterOrig.name+".modifiers[#Morpher]["+ (NumMorpher CharacterOrig "WIDE")as string +"] \"if X_Position > 0 then X_Position*100 else 0 \""))--JawWide
	if Names_Flg[GetArrayNum Names "Narrow"]==true do(execute ("paramWire.connect $Jaw_open_ctrl.pos.controller[#X_Position] $"+CharacterOrig.name+".modifiers[#Morpher]["+ (NumMorpher CharacterOrig "Narrow")as string +"] \"if X_Position < 0 then -X_Position*100 else 0\""))--Narrow

	if Names_Flg[GetArrayNum Names "Reye_cls"]==true do(execute ("paramWire.connect $Reye_cls_ctrl.pos.controller[#Z_Position] $"+CharacterOrig.name+".modifiers[#Morpher]["+ (NumMorpher CharacterOrig "Reye_cls")as string +"] \"if Z_Position < 0 then -Z_Position*100 else 0 \""))--ReyeClose
	if Names_Flg[GetArrayNum Names "Leye_cls"]==true do(execute ("paramWire.connect $Leye_cls_ctrl.pos.controller[#Z_Position] $"+CharacterOrig.name+".modifiers[#Morpher]["+ (NumMorpher CharacterOrig "Leye_cls")as string +"] \"if Z_Position < 0 then -Z_Position*100 else 0\""))--LeyeClose

	if Names_Flg[GetArrayNum Names "Jaw_Full_Open"]==true do(execute ("paramWire.connect $Jaw_open_ctrl.pos.controller[#Z_Position] $"+CharacterOrig.name+".modifiers[#Morpher]["+ (NumMorpher CharacterOrig "Jaw_Full_Open")as string +"] \"if Z_Position < 0 then -Z_Position*100 else 0 \""))--JawOpen
	if Names_Flg[GetArrayNum Names "JawClosed"]==true do(execute ("paramWire.connect $Jaw_open_ctrl.pos.controller[#Z_Position] $"+CharacterOrig.name+".modifiers[#Morpher]["+ (NumMorpher CharacterOrig "JawClosed")as string +"] \"if Z_Position > 0 then Z_Position*100 else 0 \""))--JawClosed

	if Names_Flg[GetArrayNum Names "JawFwd"]==true do(execute ("paramWire.connect $Jaw_Fwd_ctrl.pos.controller[#Z_Position] $"+CharacterOrig.name+".modifiers[#Morpher]["+ (NumMorpher CharacterOrig "JawFwd")as string +"] \"if Z_Position > 0 then Z_Position*100 else 0\""))--JawFwd
	if Names_Flg[GetArrayNum Names "JawBkwd"]==true do(execute ("paramWire.connect $Jaw_Fwd_ctrl.pos.controller[#Z_Position] $"+CharacterOrig.name+".modifiers[#Morpher]["+ (NumMorpher CharacterOrig "JawBkwd")as string +"] \"if Z_Position < 0 then -Z_Position*100 else 0\""))--JawBackwards

	if Names_Flg[GetArrayNum Names "JawLeft"]==true do(execute ("paramWire.connect $Jaw_Fwd_ctrl.pos.controller[#X_Position] $"+CharacterOrig.name+".modifiers[#Morpher]["+ (NumMorpher CharacterOrig "JawLeft")as string +"] \"if X_Position > 0 then X_Position*100 else 0\""))--JawLeft
	if Names_Flg[GetArrayNum Names "JawRight"]==true do(execute ("paramWire.connect $Jaw_Fwd_ctrl.pos.controller[#X_Position] $"+CharacterOrig.name+".modifiers[#Morpher]["+ (NumMorpher CharacterOrig "JawRight")as string +"] \"if X_Position < 0 then -X_Position*100 else 0\""))--JawRight
	
	if Names_Flg[GetArrayNum Names "eye_roll_Rght"]==true do(
	CharacterOrig.modifiers[#Morpher][(NumMorpher CharacterOrig "eye_roll_Rght")].controller=float_script()
	(CharacterOrig.modifiers[#Morpher][(NumMorpher CharacterOrig "eye_roll_Rght")].controller).AddTarget "OjoMain"  $Ojo_Right_Ctrl.position.z_position.controller
	(CharacterOrig.modifiers[#Morpher][(NumMorpher CharacterOrig "eye_roll_Rght")].controller).AddTarget "OjoNorm"  $OjoRectangle.position.z_position.controller
	(CharacterOrig.modifiers[#Morpher][(NumMorpher CharacterOrig "eye_roll_Rght")].controller).AddTarget "Multip"  $AutoEyeLids_Cntrl.position.z_position.controller
	(CharacterOrig.modifiers[#Morpher][(NumMorpher CharacterOrig "eye_roll_Rght")].controller).script="if (OjoNorm+OjoMain) < 0 then \n resultado=-(OjoNorm+OjoMain)*100*Multip \n else resultado=0 \n resultado "
	)
	if Names_Flg[GetArrayNum Names "eye_roll_lf"]==true do(
	CharacterOrig.modifiers[#Morpher][(NumMorpher CharacterOrig "eye_roll_lf")].controller=float_script()
	(CharacterOrig.modifiers[#Morpher][(NumMorpher CharacterOrig "eye_roll_lf")].controller).AddTarget "OjoMain"  $Ojo_Left_Ctrl.position.z_position.controller
	(CharacterOrig.modifiers[#Morpher][(NumMorpher CharacterOrig "eye_roll_lf")].controller).AddTarget "OjoNorm"  $OjoRectangle.position.z_position.controller
	(CharacterOrig.modifiers[#Morpher][(NumMorpher CharacterOrig "eye_roll_lf")].controller).AddTarget "Multip"  $AutoEyeLids_Cntrl.position.z_position.controller
	(CharacterOrig.modifiers[#Morpher][(NumMorpher CharacterOrig "eye_roll_lf")].controller).script="if (OjoNorm+OjoMain) < 0 then \n resultado=-(OjoNorm+OjoMain)*100*Multip \n else resultado=0 \n resultado"
	)
	--execute ("paramWire.connect $Ojo_Right_Ctrl.pos.controller[#Z_Position] $"+CharacterOrig.name+".modifiers[#Morpher]["+ (NumMorpher CharacterOrig "eye_roll_Rght")as string +"] \"if Z_Position < 0 then -Z_Position*100 else 0\"")--EyeRollRight
	--execute ("paramWire.connect $Ojo_Left_Ctrl.pos.controller[#Z_Position] $"+CharacterOrig.name+".modifiers[#Morpher]["+ (NumMorpher CharacterOrig "eye_roll_lf")as string +"] \"if Z_Position < 0 then -Z_Position*100 else 0\"")--EyeRollRight
	--paramWire.connect $Jaw_open_ctrl.pos.controller[#Z_Position] $Point004.rotation.controller[#X_Rotation] "degtorad(if Z_position <-1 then 40 else( if Z_position>0 then 0 else -Z_Position*40))"
	--paramWire.connect $Jaw_open_ctrl.pos.controller[#Z_Position] $JawBone.rotation.controller[#Z_Rotation] "degtorad(if Z_position <-1 then -40 else( if Z_position>0 then 0 else Z_Position*40))"
	--paramWire.connect $Jaw_Fwd_ctrl.pos.controller[#Z_Position] $JawBone.position.controller[#X_Position] "Z_Position"
	--paramWire.connect $Jaw_Fwd_ctrl.pos.controller[#X_Position] $JawBone.rotation.controller[#Y_rotation] "X_Position*40"
	

	
)

	/**************************************************************/
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
/*Funcion que Desabilita las banderas de la cadena que no se encuentre en la escena Es muy parecida a checa Morphers, pero regresa el arreglo de Verdaderos Falsos */
fn DisableFlags names Names_Flg=
	(
		for i in names do
			if ((execute ("in objects $"+i))!=undefined) then 
				(
				if ((execute ("in objects $"+i)).name!=i) then
					Names_Flg[GetArrayNum names i]=False;
				else
					Names_Flg[GetArrayNum names i]=True;
				)
			else
					Names_Flg[GetArrayNum names i]=False;
	return Names_Flg;
	)	
/*Funcion que checa que existan los Objetos Listados en la Cadena Names se utiliza para checar los morphers*/
fn checaMorphers names=
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
/*Funcion que checa si existe un elemento en el arreglo*/
	fn Existe Arreglo elemento=
	(
		for contenido in Arreglo do 
			if elemento==contenido do
				return true;
		return false;
	)

rollout LinkMorphers "Link Morphers" width:300 height:267
( local Controls=#(
						"Reye_cls_ctrl",
						"Leye_cls_ctrl",
						"RBrowOut_Up_Dn_ctrl",
						"LBrowOut_Up_Dn_ctrl",
						"Ojo_Right_Ctrl",
						"Ojo_Left_Ctrl",
						"OjoRectangle",
						"Rsquint_ctrl",
						"Lsquint_ctrl",
						"UprLip_Up_Dn_ctrl",
						"Jaw_open_ctrl",
						"Jaw_Fwd_ctrl",
						"LEye",
						"REye",
						"Browsqueeze_ctrl","AutoEyeLids_Cntrl");
	local Controls_Flg=#(true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true);
	local Names=#(
				  "Reye_cls",
				  "Leye_cls",
				  "WIDE", 
				  "Narrow",
				  "UprLip_Up",
				  "UprLip_Dn",
				  "LSmile",
				  "RSmile",
				  "LFrown" ,
				  "RFrown", 
				  "LBrowOut_Up",
				  "RBrowOut_Up",
				  "LBrowOut_Dn", 
				  "RBrowOut_Dn" ,
				  "LBrowIn_Up",
				  "RBrowIn_Up",
				  "LBrowIn_Dn", 
				  "RBrowIn_Dn" ,
				  "Browsqueeze",
				  "LSquint",
	              "RSquint",
				  "eye_roll_lf",
				  "eye_roll_Rght",
				  "JawLeft",
				  "JawRight",
				  "Jaw_Full_Open",
				  "JawClosed",
				  "JawFwd",
				  "JawBkwd");
	local Names_Flg=#(true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true);
	local Unique=#(
				  "Character",
		          "Reye_half_cls",
				  "Leye_half_cls",
				  "Jaw_Half_Open",
				  "OjosLookAt",
				  "OjosLookAt_L",
				  "OjosLookAt_R",
				  "Teeth_Dn","Teeth_Up","Tonge","TongeJaw_Half_Open");
	local Unique_Flg=#(true,true,true,true,true,true,true,true,true,true,true);	  
	local TeethDn=#(
				  "TJawLeft",
		          "TJawRight",
				  "TJaw_Full_Open",
				  "TJaw_Half_Open",
				  "TJawFwd",
				  "TJawBkwd",
				  "Teeth_DnWide");
	local TeethDn_Flg=#(true,true,true,true,true,true,true);
	local TeethUp=#("Teeth_UpWide");
    local TeethUp_Flg=#(true);
	local Tonge=#(
				  "TongeJawLeft",
		          "TongeJawRight",
				  "TongeJaw_Full_Open",
				  "TongeJawFwd",
				  "TongeJawBkwd",
				  "TongeWide");
	local Tonge_Flg=#(true,true,true,true,true,true);

	button btn1 "Check" pos:[9,12] width:60 height:28
	button btn2 "Ojos" pos:[79,12] width:60 height:28
	button btn3 "Link" pos:[149,12] width:60 height:28
	button btn4 "Teeth" pos:[219,12] width:60 height:28
	button btn5 "Tonge" pos:[219,47] width:60 height:28
	button btn6 "Disable" pos:[289,12] width:60 height:28
				  
	editText Info "" pos:[8,56] width:200 height:106 enabled:true
	checkbox chk1 "Morphers" pos:[219,85] width:101 height:16
	checkbox chk2 "Geometria" pos:[219,105] width:101 height:16
    checkbox chk3 "Controles" pos:[219,125] width:101 height:16
    checkbox chk4 "Dientes  " pos:[219,145] width:101 height:16
	checkbox chk5 "Tonge " pos:[219,165] width:101 height:16
				  
	on btn1 pressed  do
	(
		Info.text= " " ;
		if chk1.state==true do 
			Info.text = checaMorphers (Names)
		if chk2.state==true do
			Info.text =Info.text+"\n"+checaMorphers (Unique)
		if chk3.state==true do
		    Info.text =Info.text+"\n"+checaMorphers (Controls)
		if chk4.state==true do
			Info.text =Info.text+"\n"+checaMorphers (TeethDn)+checaMorphers (TeethUp);
		if chk5.state==true do
			Info.text =Info.text+"\n"+checaMorphers (Tonge);
	)
	on btn2 pressed  do
	(                   
		SetupEyes();
	)
   on btn3 pressed  do
	(                   
	LinkM $Character  Names Names_Flg Unique Unique_Flg
	)
	on btn4 pressed  do
	(
	 LinkTeeth $Character TeethDn TeethDn_Flg Unique Unique_Flg
	)
	on btn5 pressed  do
	(
	 LinkTonge $Character Tonge
	)
	on btn6 pressed  do
	(
	Names_Flg=DisableFlags Names Names_Flg
	Unique_Flg=DisableFlags Unique Unique_Flg
	TeethDn_Flg=DisableFlags TeethDn TeethDn_Flg 
	TeethUp_Flg=DisableFlags  TeethUp TeethUp_Flg
	Tonge_Flg=DisableFlags  Tonge Tonge_Flg
	Info.text= "morphers desabilitados " ;
	)
)
theNewFloater = newRolloutFloater "LinkMorphers" 500 420
addRollout LinkMorphers theNewFloater

