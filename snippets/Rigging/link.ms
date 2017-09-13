/**********************
	Funcion regresa True  Si existe un modificador Morpher en el objeto
	***********************/
	fn existeMorpher a=
		(
			if a.modifiers["Morpher"]!=undefined then
					return true
			else 
					return false
		)
		/********************************/
	fn LinkTonge CharacterOrig Names=(
		select $Tonge
		if ((existeMorpher $Tonge)==False) do
			(
				addmodifier  $Tonge (Morpher())
			)
				n=1
		for i in Names do
				(		 
				WM3_MC_BuildFromNode $Tonge.modifiers["Morpher"]  n  (execute("$"+i))
				n=n+1;
				)
				WM3_AddProgressiveMorphNode $Tonge.modifiers["Morpher"] (NumMorpher $Tonge "TongeJaw_Full_Open")  $TongeJaw_Half_Open
				WM3_SetProgressiveMorphWeight $Tonge.modifiers["Morpher"]  (NumMorpher $Tonge "TongeJaw_Full_Open") $TongeJaw_Half_Open 50.0
				WM3_SetProgressiveMorphWeight $Tonge.modifiers["Morpher"]  (NumMorpher $Tonge "TongeJaw_Full_Open") $TongeJaw_Full_Open 100.0
			
				execute ("paramWire.connect $"+CharacterOrig.name+".modifiers[#Morpher]["+(NumMorpher CharacterOrig "JawLeft") as string +"] $Tonge.modifiers[#Morpher]["+ (NumMorpher $Tonge "TongeJawLeft") as string +"] \""+ (substituteString ((CharacterOrig.modifiers[#Morpher][(NumMorpher CharacterOrig "JawLeft")])as string) "SubAnim:" "")+"_" +"\" ")
				execute ("paramWire.connect $"+CharacterOrig.name+".modifiers[#Morpher]["+(NumMorpher CharacterOrig "JawRight") as string +"] $Tonge.modifiers[#Morpher]["+ (NumMorpher $Tonge "TongeJawRight") as string +"] \""+ (substituteString ((CharacterOrig.modifiers[#Morpher][(NumMorpher CharacterOrig "JawRight")])as string) "SubAnim:" "")+"_" +"\" ")
				execute ("paramWire.connect $"+CharacterOrig.name+".modifiers[#Morpher]["+(NumMorpher CharacterOrig "Jaw_Full_Open") as string +"] $Tonge.modifiers[#Morpher]["+ (NumMorpher $Tonge "TongeJaw_Full_Open") as string +"] \""+ (substituteString ((CharacterOrig.modifiers[#Morpher][(NumMorpher CharacterOrig "Jaw_Full_Open")])as string) "SubAnim:" "")+"_" +"\" ")
				execute ("paramWire.connect $"+CharacterOrig.name+".modifiers[#Morpher]["+(NumMorpher CharacterOrig "JawFwd") as string +"] $Tonge.modifiers[#Morpher]["+ (NumMorpher $Tonge "TongeJawFwd") as string +"] \""+ (substituteString ((CharacterOrig.modifiers[#Morpher][(NumMorpher CharacterOrig "JawFwd")])as string) "SubAnim:" "")+"_" +"\" ")
				execute ("paramWire.connect $"+CharacterOrig.name+".modifiers[#Morpher]["+(NumMorpher CharacterOrig "JawBkwd") as string +"] $Tonge.modifiers[#Morpher]["+ (NumMorpher $Tonge "TongeJawBkwd") as string +"] \""+ (substituteString ((CharacterOrig.modifiers[#Morpher][(NumMorpher CharacterOrig "JawBkwd")])as string) "SubAnim:" "")+"_" +"\" ")
				execute ("paramWire.connect $"+CharacterOrig.name+".modifiers[#Morpher]["+(NumMorpher CharacterOrig "WIDE") as string +"] $Tonge.modifiers[#Morpher]["+ (NumMorpher $Tonge "TongeWide") as string +"] \""+ (substituteString ((CharacterOrig.modifiers[#Morpher][(NumMorpher CharacterOrig "WIDE")])as string) "SubAnim:" "")+"_" +"\" ")
		)
		
	/**************
	/***********************************************************/
	fn LinkTeeth CharacterOrig Names=(
		select $Teeth_Dn
		if ((existeMorpher $Teeth_Dn)==False) do
			(
				addmodifier  $Teeth_Dn (Morpher())
			
				n=1
		for i in Names do
				(		 
				WM3_MC_BuildFromNode $Teeth_Dn.modifiers["Morpher"]  n  (execute("$"+i))
				n=n+1;
				)
				WM3_AddProgressiveMorphNode $Teeth_Dn.modifiers["Morpher"] (NumMorpher $Teeth_Dn "TJaw_Full_Open")  $TJaw_Half_Open
				WM3_SetProgressiveMorphWeight $Teeth_Dn.modifiers["Morpher"]  (NumMorpher $Teeth_Dn "TJaw_Full_Open") $TJaw_Half_Open 50.0
				WM3_SetProgressiveMorphWeight $Teeth_Dn.modifiers["Morpher"]  (NumMorpher $Teeth_Dn "TJaw_Full_Open") $TJaw_Full_Open 100.0
			)
				execute ("paramWire.connect $"+CharacterOrig.name+".modifiers[#Morpher]["+(NumMorpher CharacterOrig "JawLeft") as string +"] $Teeth_Dn.modifiers[#Morpher]["+ (NumMorpher $Teeth_Dn "TJawLeft") as string +"] \""+ (substituteString ((CharacterOrig.modifiers[#Morpher][(NumMorpher CharacterOrig "JawLeft")])as string) "SubAnim:" "")+"_" +"\" ")
				execute ("paramWire.connect $"+CharacterOrig.name+".modifiers[#Morpher]["+(NumMorpher CharacterOrig "JawRight") as string +"] $Teeth_Dn.modifiers[#Morpher]["+ (NumMorpher $Teeth_Dn "TJawRight") as string +"] \""+ (substituteString ((CharacterOrig.modifiers[#Morpher][(NumMorpher CharacterOrig "JawRight")])as string) "SubAnim:" "")+"_" +"\" ")
				execute ("paramWire.connect $"+CharacterOrig.name+".modifiers[#Morpher]["+(NumMorpher CharacterOrig "Jaw_Full_Open") as string +"] $Teeth_Dn.modifiers[#Morpher]["+ (NumMorpher $Teeth_Dn "TJaw_Full_Open") as string +"] \""+ (substituteString ((CharacterOrig.modifiers[#Morpher][(NumMorpher CharacterOrig "Jaw_Full_Open")])as string) "SubAnim:" "")+"_" +"\" ")
				execute ("paramWire.connect $"+CharacterOrig.name+".modifiers[#Morpher]["+(NumMorpher CharacterOrig "JawFwd") as string +"] $Teeth_Dn.modifiers[#Morpher]["+ (NumMorpher $Teeth_Dn "TJawFwd") as string +"] \""+ (substituteString ((CharacterOrig.modifiers[#Morpher][(NumMorpher CharacterOrig "JawFwd")])as string) "SubAnim:" "")+"_" +"\" ")
				execute ("paramWire.connect $"+CharacterOrig.name+".modifiers[#Morpher]["+(NumMorpher CharacterOrig "JawBkwd") as string +"] $Teeth_Dn.modifiers[#Morpher]["+ (NumMorpher $Teeth_Dn "TJawBkwd") as string +"] \""+ (substituteString ((CharacterOrig.modifiers[#Morpher][(NumMorpher CharacterOrig "JawBkwd")])as string) "SubAnim:" "")+"_" +"\" ")
				execute ("paramWire.connect $"+CharacterOrig.name+".modifiers[#Morpher]["+(NumMorpher CharacterOrig "WIDE") as string +"] $Teeth_Dn.modifiers[#Morpher]["+ (NumMorpher $Teeth_Dn "Teeth_DnWide") as string +"] \""+ (substituteString ((CharacterOrig.modifiers[#Morpher][(NumMorpher CharacterOrig "WIDE")])as string) "SubAnim:" "")+"_" +"\" ")
			
		select $Teeth_Up
		if (existeMorpher $Teeth_Up==False) do
			(
				addmodifier  $Teeth_Up (Morpher())
			
		WM3_MC_BuildFromNode $Teeth_Up.modifiers["Morpher"]  1  $Teeth_UpWide
			)
		execute ("paramWire.connect $"+CharacterOrig.name+".modifiers[#Morpher]["+(NumMorpher CharacterOrig "WIDE") as string +"] $Teeth_Up.modifiers[#Morpher]["+ (NumMorpher $Teeth_Up "Teeth_UpWide") as string +"] \""+ (substituteString ((CharacterOrig.modifiers[#Morpher][(NumMorpher CharacterOrig "WIDE")])as string) "SubAnim:" "")+"_" +"\" ")
		
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
	
	/**************************************************/
	fn LinkM CharacterOrig Names=(
		select CharacterOrig
		if (existeMorpher CharacterOrig==False) do
			(
				addmodifier  CharacterOrig (Morpher())
				n=1
				for i in Names do
					(		 
						WM3_MC_BuildFromNode CharacterOrig.modifiers["Morpher"]  n  (execute("$"+i))
						n=n+1;
					)
																   
				WM3_AddProgressiveMorphNode CharacterOrig.modifiers["Morpher"] (NumMorpher CharacterOrig "Jaw_Full_Open")  $Jaw_Half_Open
				WM3_SetProgressiveMorphWeight CharacterOrig.modifiers["Morpher"]  (NumMorpher CharacterOrig "Jaw_Full_Open") $Jaw_Half_Open 50.0
				WM3_SetProgressiveMorphWeight CharacterOrig.modifiers["Morpher"]  (NumMorpher CharacterOrig "Jaw_Full_Open") $Jaw_Full_Open 100.0
					
				WM3_AddProgressiveMorphNode CharacterOrig.modifiers["Morpher"] (NumMorpher CharacterOrig "Reye_cls")  $Reye_half_cls
				WM3_SetProgressiveMorphWeight CharacterOrig.modifiers["Morpher"]  (NumMorpher CharacterOrig "Reye_cls") $Reye_half_cls 50.0
				WM3_SetProgressiveMorphWeight CharacterOrig.modifiers["Morpher"]  (NumMorpher CharacterOrig "Reye_cls") $Reye_cls 100.0
				
				WM3_AddProgressiveMorphNode CharacterOrig.modifiers["Morpher"] (NumMorpher CharacterOrig "Leye_cls")  $Leye_half_cls
				WM3_SetProgressiveMorphWeight CharacterOrig.modifiers["Morpher"]  (NumMorpher CharacterOrig "Leye_cls") $Leye_half_cls 50.0
				WM3_SetProgressiveMorphWeight CharacterOrig.modifiers["Morpher"]  (NumMorpher CharacterOrig "Leye_cls") $Leye_cls 100.0
				
			)
			
	    execute ("paramWire.connect $RBrowOut_Up_Dn_ctrl.pos.controller[#Z_Position] $"+CharacterOrig.name+".modifiers[#Morpher]["+ (NumMorpher CharacterOrig "RBrowOut_Up")as string +"] \"if Z_Position>0 then Z_Position*100 else 0\" ")--RBrowUp
	    execute( "paramWire.connect $LBrowOut_Up_Dn_ctrl.pos.controller[#Z_Position] $"+CharacterOrig.name+".modifiers[#Morpher]["+ (NumMorpher CharacterOrig "LBrowOut_Up") as string +"]\"if Z_Position>0 then Z_Position*100 else 0\" ")--LBrowUp
		execute( "paramWire.connect $LBrowOut_Up_Dn_ctrl.pos.controller[#Z_Position] $"+CharacterOrig.name+".modifiers[#Morpher]["+ (NumMorpher CharacterOrig "LBrowOut_Dn")as string +"]\"if Z_Position<0 then -Z_Position*100 else 0\" ")   --LBrowDown
		execute ("paramWire.connect $RBrowOut_Up_Dn_ctrl.pos.controller[#Z_Position] $"+CharacterOrig.name+".modifiers[#Morpher]["+ (NumMorpher CharacterOrig "RBrowOut_Dn")as string +"] \"if Z_Position<0 then -Z_Position*100 else 0\" ")--RBrowDown

	    execute ("paramWire.connect $RBrowOut_Up_Dn_ctrl.pos.controller[#X_Position] $"+CharacterOrig.name+".modifiers[#Morpher]["+ (NumMorpher CharacterOrig "RBrowIn_Up")as string +"] \"if X_Position>0 then X_Position*100 else 0\" ")--RBrowUp
	    execute ("paramWire.connect $RBrowOut_Up_Dn_ctrl.pos.controller[#X_Position] $"+CharacterOrig.name+".modifiers[#Morpher]["+ (NumMorpher CharacterOrig "RBrowIn_Dn")as string +"] \"if X_Position<0 then -X_Position*100 else 0\" ")--RBrowDown
		execute( "paramWire.connect $LBrowOut_Up_Dn_ctrl.pos.controller[#X_Position] $"+CharacterOrig.name+".modifiers[#Morpher]["+ (NumMorpher CharacterOrig "LBrowIn_Up") as string +"]\"if X_Position<0 then -X_Position*100 else 0\" ")--LBrowUp	
		execute( "paramWire.connect $LBrowOut_Up_Dn_ctrl.pos.controller[#X_Position] $"+CharacterOrig.name+".modifiers[#Morpher]["+ (NumMorpher CharacterOrig "LBrowIn_Dn")as string +"]\"if X_Position>0 then X_Position*100 else 0\" ")   --LBrowDown
		
		
		execute ("paramWire.connect $Browsqueeze_ctrl.pos.controller[#X_Position] $"+CharacterOrig.name+".modifiers[#Morpher]["+ (NumMorpher CharacterOrig "Browsqueeze")as string +"] \"if X_Position>-50 then (X_position*100) else -50\"")--Browsqueeze
		
		execute ("paramWire.connect $UprLip_Up_Dn_ctrl.pos.controller[#Z_Position] $"+CharacterOrig.name+".modifiers[#Morpher]["+ (NumMorpher CharacterOrig "UprLip_Up")as string +"] \"if Z_Position>0 then (Z_position*100) else 0\"")--UperLip
		execute ("paramWire.connect $UprLip_Up_Dn_ctrl.pos.controller[#Z_Position] $"+CharacterOrig.name+".modifiers[#Morpher]["+ (NumMorpher CharacterOrig "UprLip_Dn")as string +"] \"if Z_Position<0 then (-Z_position*100) else 0\"")--LowerLip


		execute ("paramWire.connect $Lsquint_ctrl.pos.controller[#Z_Position] $"+CharacterOrig.name+".modifiers[#Morpher]["+ (NumMorpher CharacterOrig "LSmile")as string +"] \"if Z_Position>0 then (Z_position*100) else 0\"")--LSmile
		execute ("paramWire.connect $Rsquint_ctrl.pos.controller[#Z_Position] $"+CharacterOrig.name+".modifiers[#Morpher]["+ (NumMorpher CharacterOrig "RSmile")as string +"] \"if Z_Position>0 then (Z_position*100) else 0\"")--RSmile
		execute ("paramWire.connect $Lsquint_ctrl.pos.controller[#Z_Position] $"+CharacterOrig.name+".modifiers[#Morpher]["+ (NumMorpher CharacterOrig "LFrown")as string +"] \"if Z_Position<0 then (-Z_position*100) else 0\"")--LFrown
		execute ("paramWire.connect $Rsquint_ctrl.pos.controller[#Z_Position] $"+CharacterOrig.name+".modifiers[#Morpher]["+ (NumMorpher CharacterOrig "RFrown")as string +"] \"if Z_Position<0 then (-Z_position*100) else 0\"")--RFrown
		
		execute ("paramWire.connect $Lsquint_ctrl.pos.controller[#X_Position] $"+CharacterOrig.name+".modifiers[#Morpher]["+ (NumMorpher CharacterOrig "LSquint")as string +"] \"X_Position*100\" ")--Left Squint
		execute ("paramWire.connect $Rsquint_ctrl.pos.controller[#X_Position] $"+CharacterOrig.name+".modifiers[#Morpher]["+ (NumMorpher CharacterOrig "RSquint")as string +"] \"-X_Position*100\" ")--Right Squint
			

		execute ("paramWire.connect $Jaw_open_ctrl.pos.controller[#X_Position] $"+CharacterOrig.name+".modifiers[#Morpher]["+ (NumMorpher CharacterOrig "WIDE")as string +"] \"if X_Position > 0 then X_Position*100 else 0 \"")--JawWide
		execute ("paramWire.connect $Jaw_open_ctrl.pos.controller[#X_Position] $"+CharacterOrig.name+".modifiers[#Morpher]["+ (NumMorpher CharacterOrig "Narrow")as string +"] \"if X_Position < 0 then -X_Position*100 else 0\"")--Narrow

		execute ("paramWire.connect $Reye_cls_ctrl.pos.controller[#Z_Position] $"+CharacterOrig.name+".modifiers[#Morpher]["+ (NumMorpher CharacterOrig "Reye_cls")as string +"] \"if Z_Position < 0 then -Z_Position*100 else 0 \"")--ReyeClose
		execute ("paramWire.connect $Leye_cls_ctrl.pos.controller[#Z_Position] $"+CharacterOrig.name+".modifiers[#Morpher]["+ (NumMorpher CharacterOrig "Leye_cls")as string +"] \"if Z_Position < 0 then -Z_Position*100 else 0\"")--LeyeClose

		execute ("paramWire.connect $Jaw_open_ctrl.pos.controller[#Z_Position] $"+CharacterOrig.name+".modifiers[#Morpher]["+ (NumMorpher CharacterOrig "Jaw_Full_Open")as string +"] \"if Z_Position < 0 then -Z_Position*100 else 0 \"")--JawOpen
		execute ("paramWire.connect $Jaw_open_ctrl.pos.controller[#Z_Position] $"+CharacterOrig.name+".modifiers[#Morpher]["+ (NumMorpher CharacterOrig "JawClosed")as string +"] \"if Z_Position > 0 then Z_Position*300 else 0 \"")--JawClosed

		execute ("paramWire.connect $Jaw_Fwd_ctrl.pos.controller[#Z_Position] $"+CharacterOrig.name+".modifiers[#Morpher]["+ (NumMorpher CharacterOrig "JawFwd")as string +"] \"if Z_Position > 0 then Z_Position*100 else 0\"")--JawFwd
		execute ("paramWire.connect $Jaw_Fwd_ctrl.pos.controller[#Z_Position] $"+CharacterOrig.name+".modifiers[#Morpher]["+ (NumMorpher CharacterOrig "JawBkwd")as string +"] \"if Z_Position < 0 then -Z_Position*100 else 0\"")--JawBackwards

		execute ("paramWire.connect $Jaw_Fwd_ctrl.pos.controller[#X_Position] $"+CharacterOrig.name+".modifiers[#Morpher]["+ (NumMorpher CharacterOrig "JawLeft")as string +"] \"if X_Position > 0 then X_Position*100 else 0\"")--JawLeft
		execute ("paramWire.connect $Jaw_Fwd_ctrl.pos.controller[#X_Position] $"+CharacterOrig.name+".modifiers[#Morpher]["+ (NumMorpher CharacterOrig "JawRight")as string +"] \"if X_Position < 0 then -X_Position*100 else 0\"")--JawRight
		
		CharacterOrig.modifiers[#Morpher][(NumMorpher CharacterOrig "eye_roll_Rght")].controller=float_script()
		(CharacterOrig.modifiers[#Morpher][(NumMorpher CharacterOrig "eye_roll_Rght")].controller).AddTarget "OjoMain"  $Ojo_Right_Ctrl.position.z_position.controller
		(CharacterOrig.modifiers[#Morpher][(NumMorpher CharacterOrig "eye_roll_Rght")].controller).AddTarget "OjoNorm"  $OjoRectangle.position.z_position.controller
		(CharacterOrig.modifiers[#Morpher][(NumMorpher CharacterOrig "eye_roll_Rght")].controller).AddTarget "Multip"  $AutoEyeLids_Cntrl.position.z_position.controller
		(CharacterOrig.modifiers[#Morpher][(NumMorpher CharacterOrig "eye_roll_Rght")].controller).script="if (OjoNorm+OjoMain) < 0 then \n resultado=-(OjoNorm+OjoMain)*100*Multip \n else resultado=0 \n resultado "
		
		CharacterOrig.modifiers[#Morpher][(NumMorpher CharacterOrig "eye_roll_lf")].controller=float_script()
		(CharacterOrig.modifiers[#Morpher][(NumMorpher CharacterOrig "eye_roll_lf")].controller).AddTarget "OjoMain"  $Ojo_Left_Ctrl.position.z_position.controller
		(CharacterOrig.modifiers[#Morpher][(NumMorpher CharacterOrig "eye_roll_lf")].controller).AddTarget "OjoNorm"  $OjoRectangle.position.z_position.controller
		(CharacterOrig.modifiers[#Morpher][(NumMorpher CharacterOrig "eye_roll_lf")].controller).AddTarget "Multip"  $AutoEyeLids_Cntrl.position.z_position.controller
		(CharacterOrig.modifiers[#Morpher][(NumMorpher CharacterOrig "eye_roll_lf")].controller).script="if (OjoNorm+OjoMain) < 0 then \n resultado=-(OjoNorm+OjoMain)*100*Multip \n else resultado=0 \n resultado"
		
		--execute ("paramWire.connect $Ojo_Right_Ctrl.pos.controller[#Z_Position] $"+CharacterOrig.name+".modifiers[#Morpher]["+ (NumMorpher CharacterOrig "eye_roll_Rght")as string +"] \"if Z_Position < 0 then -Z_Position*100 else 0\"")--EyeRollRight
		--execute ("paramWire.connect $Ojo_Left_Ctrl.pos.controller[#Z_Position] $"+CharacterOrig.name+".modifiers[#Morpher]["+ (NumMorpher CharacterOrig "eye_roll_lf")as string +"] \"if Z_Position < 0 then -Z_Position*100 else 0\"")--EyeRollRight
		
		--paramWire.connect $Jaw_open_ctrl.pos.controller[#Z_Position] $Point004.rotation.controller[#X_Rotation] "degtorad(if Z_position <-1 then 40 else( if Z_position>0 then 0 else -Z_Position*40))"
		
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
	($LeyeOrientacion.rotation.y_rotation.controller).script="((-OjoNorm/2-OjoMain/2)/2)"
	$LeyeOrientacion.rotation.z_rotation.controller=float_script()
	($LeyeOrientacion.rotation.z_rotation.controller).AddTarget "OjoMain"  $Ojo_Left_Ctrl.position.x_position.controller
	($LeyeOrientacion.rotation.z_rotation.controller).AddTarget "OjoNorm"  $OjoRectangle.position.x_position.controller
	($LeyeOrientacion.rotation.z_rotation.controller).script="((OjoNorm/2+OjoMain/2)/2)"

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
	($ReyeOrientacion.rotation.y_rotation.controller).script="((-OjoNorm/2-OjoMain/2)/2)"
	$ReyeOrientacion.rotation.z_rotation.controller=float_script()
	($ReyeOrientacion.rotation.z_rotation.controller).AddTarget "OjoMain"  $Ojo_Right_Ctrl.position.x_position.controller
	($ReyeOrientacion.rotation.z_rotation.controller).AddTarget "OjoNorm"  $OjoRectangle.position.x_position.controller
	($ReyeOrientacion.rotation.z_rotation.controller).script="((OjoNorm/2+OjoMain/2)/2)"

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
		
	/*Funcion que checa que existan los morphers de un Objeto*/
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
			
			if (CadenaInfo ==" ") do CadenaInfo = "Se encontraron todos los morphs";
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

	rollout LinkMorphers "Link Morphers" width:165 height:267
	( 
		local Controls=#(
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
		local Unique=#(
					  "Character",
			          "Reye_half_cls",
					  "Leye_half_cls",
					  "Jaw_Half_Open",
					  "OjosLookAt",
					  "OjosLookAt_L",
					  "OjosLookAt_R",
					  "Teeth_Dn","Teeth_Up","Tonge","TongeJaw_Half_Open");
		local TeethDn=#(
					  "TJawLeft",
			          "TJawRight",
					  "TJaw_Full_Open",
					  "TJaw_Half_Open",
					  "TJawFwd",
					  "TJawBkwd",
					 "Teeth_DnWide");
		local TeethUp=#("Teeth_UpWide");
	    
		local Tonge=#(
					  "TongeJawLeft",
			          "TongeJawRight",
					  "TongeJaw_Full_Open",
					  "TongeJawFwd",
					  "TongeJawBkwd",
						"TongeWide");
					  
		button btn1 "Check" pos:[9,12] width:60 height:28
		button btn2 "Ojos" pos:[79,12] width:60 height:28
		button btn3 "Link" pos:[149,12] width:60 height:28
		button btn4 "Teeth" pos:[219,12] width:60 height:28
		button btn5 "Tonge" pos:[219,47] width:60 height:28
					  
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
			LinkM $Character  Names
		)
		on btn4 pressed  do
		(
		 LinkTeeth $Character TeethDn
		)
		on btn5 pressed  do
		(
		 LinkTonge $Character Tonge
		)
	)
	theNewFloater = newRolloutFloater "LinkMorphers" 300 220
	addRollout LinkMorphers theNewFloater