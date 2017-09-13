
Names=#("LBrowOut_Up","RBrowOut_up","LBrow_Dn","RBrow_Dn","Lsquint","Rsquint","UprLip_Up","UprLip_Dn", "LSmile","RSmile","LFrown","RFrown", "Jaw_Fwd","Jaw_open",
	         "Wide","Narrow")
g=selection[1]
f=morpher()
addmodifier g f
n=1
/*
			 for i in Names do
	( 
		/* select (execute("$"+g.name+"_"+i))*//*
		d=selection[1]
		WM3_MC_BuildFromNode f  n  (execute("$"+g.name+"_"+i))
		n=n+1
	) 
	*/
n=17

execute( "paramWire.connect $"+g.name+"_LBrowOut_Up_Dn_ctrl.pos.controller[#Z_Position] $Juan.modifiers[#Morpher][1]\"if Z_Position>0 then Z_Position*100 else 0\" ")/*LBrowUp*/
execute ("paramWire.connect $"+g.name+"_RBrowOut_Up_Dn_ctrl.pos.controller[#Z_Position] $Juan.modifiers[#Morpher][2] \"if Z_Position>0 then Z_Position*100 else 0\" ")/*RBrowUp */
execute( "paramWire.connect $"+g.name+"_LBrowOut_Up_Dn_ctrl.pos.controller[#Z_Position] $Juan.modifiers[#Morpher][3]\"if Z_Position<0 then -Z_Position*100 else 0\" ")   /*LBrowDown*/
execute ("paramWire.connect $"+g.name+"_RBrowOut_Up_Dn_ctrl.pos.controller[#Z_Position] $Juan.modifiers[#Morpher][4] \"if Z_Position<0 then -Z_Position*100 else 0\" ")/*RBrowDown*/
	
execute ("paramWire.connect $"+g.name+"_Lsquint_ctrl.pos.controller[#Z_Position] $Juan.modifiers[#Morpher][5] \"Z_Position*100\" ")/*Left Squint*/
execute ("paramWire.connect $"+g.name+"_Rsquint_ctrl.pos.controller[#Z_Position] $Juan.modifiers[#Morpher][6] \"Z_Position*100\" ")/*Right Squint*/
	
execute ("paramWire.connect $"+g.name+"_UprLip_Up_Dn_ctrl.pos.controller[#Z_Position] $Juan.modifiers[#Morpher][7] \"if Z_Position>0 then (Z_position*100) else 0\"")/*UperLip*/
execute ("paramWire.connect $"+g.name+"_UprLip_Up_Dn_ctrl.pos.controller[#Z_Position] $Juan.modifiers[#Morpher][8] \"if Z_Position<0 then (-Z_position*100) else 0\"")/*LowerLip*/

/*execute ("paramWire.connect $"+g.name+"_LSmile_LFrown_ctrl.pos.controller[#Z_Position] $Juan.modifiers[#Morpher][9] \"if Z_Position>0 then (Z_position*100) else 0\"")/*LSmile*/
/*execute ("paramWire.connect $"+g.name+"_RSmile_RFrown_ctrl.pos.controller[#Z_Position] $Juan.modifiers[#Morpher][10] \"if Z_Position>0 then (Z_position*100) else 0\"")/*RSmile*/

execute ("paramWire.connect $"+g.name+"_Lsquint_ctrl.pos.controller[#X_Position] $Juan.modifiers[#Morpher][9] \"if X_Position>0 then (X_position*100) else 0\"")/*LSmile*/
execute ("paramWire.connect $"+g.name+"_Rsquint_ctrl.pos.controller[#X_Position] $Juan.modifiers[#Morpher][10] \"if X_Position<0 then (-X_position*100) else 0\"")/*RSmile*/

/*execute ("paramWire.connect $"+g.name+"_LSmile_LFrown_ctrl.pos.controller[#Z_Position] $Juan.modifiers[#Morpher][11] \"if Z_Position<0 then (-Z_position*100) else 0 \"")/*LFrown*/
/*execute ("paramWire.connect $"+g.name+"_RSmile_RFrown_ctrl.pos.controller[#Z_Position] $Juan.modifiers[#Morpher][12] \"if Z_Position<0 then (-Z_position*100) else 0 \"")/*RFrown*/

execute ("paramWire.connect $"+g.name+"_Lsquint_ctrl.pos.controller[#X_Position] $Juan.modifiers[#Morpher][11] \"if X_Position<0 then (-X_position*100) else 0\"")/*LFrown*/
execute ("paramWire.connect $"+g.name+"_Rsquint_ctrl.pos.controller[#X_Position] $Juan.modifiers[#Morpher][12] \"if X_Position>0 then (X_position*100) else 0\"")/*RFrown*/


/*execute ("paramWire.connect $"+g.name+"_LSmile_LFrown_ctrl.pos.controller[#Z_Position] $Juan.modifiers[#Morpher][11] \"if Z_Position<0 then (-Z_position*100) else 0 \"")/*LFrown*/
/*execute ("paramWire.connect $"+g.name+"_RSmile_RFrown_ctrl.pos.controller[#Z_Position] $Juan.modifiers[#Morpher][12] \"if Z_Position<0 then (-Z_position*100) else 0 \"")/*RFrown*/

--execute ("paramWire.connect $"+g.name+"_Jaw_Fwd_ctrl.pos.controller[#Z_Position] $Juan.modifiers[#Morpher][13] \"Z_Position*100\"")/*JawFwd*/
--execute ("paramWire.connect $"+g.name+"_Jaw_open_ctrl.pos.controller[#Z_Position] $Juan.modifiers[#Morpher][14] \"Z_Position*100\"")/*JawOpen*/

execute ("paramWire.connect $"+g.name+"_Jaw_open_ctrl.pos.controller[#Z_Position] $Juan.modifiers[#Morpher][13]                      \"if Z_Position > 0 then Z_Position*100 else 0\"")/*JawFwd*/
execute ("paramWire.connect $"+g.name+"_Jaw_open_ctrl.pos.controller[#Z_Position] $Juan_BoneJaw.rotation.controller[#Z_Rotation] \"if Z_Position < 0 then (Z_Position + degtorad 180) else degtorad 180\"")/*JawOpen*/

execute ("paramWire.connect $"+g.name+"_Jaw_Fwd_ctrl.pos.controller[#X_Position] $Juan_BoneJaw.rotation.controller[#Y_Rotation] \"X_Position+degtorad 180\"")/*JawOpen*/

execute ("paramWire.connect $"+g.name+"_Jaw_open_ctrl.pos.controller[#X_Position] $Juan.modifiers[#Morpher][14] \"if X_Position > 0 then X_Position*100 else 0 \"")/*JawWide*/
execute ("paramWire.connect $"+g.name+"_Jaw_open_ctrl.pos.controller[#X_Position] $Juan.modifiers[#Morpher][15] \"if X_Position < 0 then -X_Position*100 else 0\"")/*Narrow*/