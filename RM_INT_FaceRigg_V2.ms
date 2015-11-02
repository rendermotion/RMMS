ScriptPath="\\\\SERVER\\Alumnos\\Rigging\\Recursos\\Includes\\"
filein (ScriptPath+"RM_FaceRiggFunctions_V2.ms")


rollout LinkMorphers "Link Morphers" width:368 height:304
(
	local Controls=#(
						"Reye_cls_ctrl",
						"Leye_cls_ctrl",
						"RBrowOut_Up_Dn_ctrl",
						"LBrowOut_Up_Dn_ctrl",
						"Ojo_Right_Ctrl",
						"Ojo_Left_Ctrl",
						"OjoRectangle",
						"Character_MD_MouthEmotion_ctrl_fc",
						"Character_MD_EyeSquint_ctrl_fc",
						"Character_MD_EyeSneer_ctrl_fc",
						"Character_MD_UprLipUpDn_ctrl_fc",
						"Jaw_open_ctrl",
						"Jaw_Fwd_ctrl",
						"LEye",
						"REye",
						"Browsqueeze_ctrl","AutoEyeLids_Cntrl");
	local Controls_Flg=#(true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true);
	local Names=#(
				  "ReyeCls",
				  "LeyeCls",
				  "Wide", 
				  "Narrow",
				  "UprLipUp",
				  "UprLipDn",
				  "LSmile",
				  "RSmile",
				  "LFrown" ,
				  "RFrown", 
				  "LBrowOutUp",
				  "RBrowOutUp",
				  "LBrowOutDn", 
				  "RBrowOutDn" ,
				  "LBrowInUp",
				  "RBrowInUp",
				  "LBrowInDn", 
				  "RBrowInDn" ,
				  "Browsqueeze",
				  "LSquint",
	              "RSquint",
				  "REyeRollLf",
				  "REyeRollRh",
				  "LEyeRollLf",
				  "LEyeRollRh",
				  "JawLeft",
				  "JawRight",
				  "JawFullOpen",
				  "JawClosed",
				  "JawFwd",
				  "JawBkwd","LSneer","RSneer");
	local Names_Flg=#(true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true,true);
	local Unique=#(
				  "Character",
		          "ReyeHalfCls",
				  "LeyeHalfCls",
				  "JawHalfOpen",
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
				  "TeethDnWide");
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

	button btn1 "Check" pos:[224,48] width:60 height:28
	button btn2 "Eyes" pos:[224,8] width:60 height:28
	button btn3 "Link" pos:[8,8] width:60 height:28
	button btn4 "Teeth" pos:[80,8] width:60 height:28
	button btn5 "Tonge" pos:[152,8] width:60 height:28
	button btn6 "Disable" pos:[224,192] width:64 height:32
				  
	edittext info "" pos:[8,48] width:200 height:240 enabled:true
	checkbox chk1 "Morphers" pos:[219,85] width:101 height:16
	checkbox chk2 "Geometria" pos:[219,105] width:101 height:16
	checkbox chk3 "Controles" pos:[219,125] width:101 height:16
	checkbox chk4 "Dientes  " pos:[219,145] width:101 height:16
	checkbox chk5 "Tonge " pos:[219,165] width:101 height:16
	button FaceInterfaceButton "Merge Face Interface" pos:[216,232] width:124 height:23
	button EyeInterfaceButton "Merge Eyes Interface" pos:[216,264] width:124 height:23
	
	button btnLinkJaw "Link Jaw" pos:[296,8] width:64 height:28
	pickButton PickJawBtn "Pick Jaw" pos:[296,48] width:64 height:27
	
	on btn1 pressed do
	(
		Info.text= " " ;
		if chk1.state==true do 
			Info.text = RMMorphersCheck (Names)
		if chk2.state==true do
			Info.text =Info.text+"\n"+RMMorphersCheck(Unique)
		if chk3.state==true do
		    Info.text =Info.text+"\n"+RMMorphersCheck (Controls)
		if chk4.state==true do
			Info.text =Info.text+"\n"+RMMorphersCheck (TeethDn)+RMMorphersCheck (TeethUp);
		if chk5.state==true do
			Info.text =Info.text+"\n"+RMMorphersCheck (Tonge);
	)
	on btn2 pressed do
	(                   
		SetupEyes();
	)
	on btn3 pressed do
	(                   
	LinkM $Character  Names Names_Flg Unique Unique_Flg
	)
	on btn4 pressed do
	(
	 LinkTeeth $Character TeethDn TeethDn_Flg Unique Unique_Flg
	)
	on btn5 pressed do
	(
	 LinkTonge $Character Tonge
	)
	on PickJawBtn picked obj do
	(
		if obj != undefined do
		(
			PickJawBtn.text=obj.name
		)
	)
	on btnLinkJaw pressed do
	(
		print "ICallLink"
		JawLink (PickJawBtn.object)
	)
	on btn6 pressed do
	(
	Names_Flg=DisableFlags Names Names_Flg
	Unique_Flg=DisableFlags Unique Unique_Flg
	TeethDn_Flg=DisableFlags TeethDn TeethDn_Flg 
	TeethUp_Flg=DisableFlags  TeethUp TeethUp_Flg
	Tonge_Flg=DisableFlags  Tonge Tonge_Flg
	Info.text= "morphers desabilitados " ;
	)
	on FaceInterfaceButton pressed do
		mergeMAXFile (ScriptPath+"Geometry\\Facialinterface\\FaceInterface.max") #select
	on EyeInterfaceButton pressed do
		mergeMAXFile (ScriptPath+"Geometry\\Facialinterface\\EyeInterface.max") #select
)
theNewFloater = newRolloutFloater "LinkMorphers" 380 320
addRollout LinkMorphers theNewFloater

