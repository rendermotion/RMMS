g=selection[1]
Controls=#(/*"Leye_half_cls_ctrl","Reye_half_cls_ctrl"*/"Reye_cls_ctrl","Leye_cls_ctrl","RBrowOut_Up_Dn_ctrl",
	             "LBrowOut_Up_Dn_ctrl","Ojo_Right_Ctrl","Ojo_Left_Ctrl","Rsquint_ctrl",
	             "Lsquint_ctrl","UprLip_Up_Dn_ctrl","Jaw_open_ctrl","Jaw_Fwd_ctrl",/*"LEye","REye",*/"BoneJaw")
	
Names=#( "LBrowOut_Up","RBrowOut_up","LBrow_Dn", "RBrow_Dn" ,"LSquint",
	             "RSquint"     ,   "UprLip_Up",     "UprLip_Dn", "LSmile"       ,"RSmile",
	             "LFrown"        ,"RFrown",          "Wide",         "Narrow"     ,"Reye_cls",
				 "Leye_cls"     /*,"Reye_half_cls",  "Leye_half_cls","JawFwd"*/
	             /*,"JawOpen"*/)
				 
error=0
for i in names do
	(
	if (execute ("in objects $"+g.name+"_"+i))== undefined do
			(
				print ("no existe el objeto "+g.name+"_"+i)
				error=1
			)
	)

for i in Controls do
	(
	if (execute ("in objects $"+g.name+"_"+i))== undefined do
			(
				print ("no existe el objeto "+g.name+"_"+i)
				error=1
			)
	)

if error==1 then 
				print ("Asegurate de seleccionar la cara del personaje que quieras Riggear")
else
(
f=morpher()
addmodifier g f
n=1
	
for i in Names do
	( 
		
			select (execute("$"+g.name+"_"+i))
			d=selection[1]
			WM3_MC_BuildFromNode f  n  (execute("$"+g.name+"_"+i))
			n=n+1
		
	)

			   
execute( "paramWire.connect $"+g.name+"_LBrowOut_Up_Dn_ctrl.pos.controller[#Z_Position] $"+g.name+".modifiers[#Morpher][1]\"if Z_Position>0 then Z_Position*100 else 0\" ")/*LBrowUp*/
execute ("paramWire.connect $"+g.name+"_RBrowOut_Up_Dn_ctrl.pos.controller[#Z_Position] $"+g.name+".modifiers[#Morpher][2] \"if Z_Position>0 then Z_Position*100 else 0\" ")/*RBrowUp */
execute( "paramWire.connect $"+g.name+"_LBrowOut_Up_Dn_ctrl.pos.controller[#Z_Position] $"+g.name+".modifiers[#Morpher][3]\"if Z_Position<0 then -Z_Position*100 else 0\" ")   /*LBrowDown*/
execute ("paramWire.connect $"+g.name+"_RBrowOut_Up_Dn_ctrl.pos.controller[#Z_Position] $"+g.name+".modifiers[#Morpher][4] \"if Z_Position<0 then -Z_Position*100 else 0\" ")/*RBrowDown*/
	
execute ("paramWire.connect $"+g.name+"_Lsquint_ctrl.pos.controller[#Z_Position] $"+g.name+".modifiers[#Morpher][5] \"Z_Position*100\" ")/*Left Squint*/
execute ("paramWire.connect $"+g.name+"_Rsquint_ctrl.pos.controller[#Z_Position] $"+g.name+".modifiers[#Morpher][6] \"Z_Position*100\" ")/*Right Squint*/
	
execute ("paramWire.connect $"+g.name+"_UprLip_Up_Dn_ctrl.pos.controller[#Z_Position] $"+g.name+".modifiers[#Morpher][7] \"if Z_Position>0 then (Z_position*100) else 0\"")/*UperLip*/
execute ("paramWire.connect $"+g.name+"_UprLip_Up_Dn_ctrl.pos.controller[#Z_Position] $"+g.name+".modifiers[#Morpher][8] \"if Z_Position<0 then (-Z_position*100) else 0\"")/*LowerLip*/

--execute ("paramWire.connect $"+g.name+"_LSmile_LFrown_ctrl.pos.controller[#Z_Position] $"+g.name+".modifiers[#Morpher][9] \"if Z_Position>0 then (Z_position*100) else 0\"")/*LSmile*/
--execute ("paramWire.connect $"+g.name+"_RSmile_RFrown_ctrl.pos.controller[#Z_Position] $"+g.name+".modifiers[#Morpher][10] \"if Z_Position>0 then (Z_position*100) else 0\"")/*RSmile*/

execute ("paramWire.connect $"+g.name+"_Lsquint_ctrl.pos.controller[#X_Position] $"+g.name+".modifiers[#Morpher][9] \"if X_Position>0 then (X_position*100) else 0\"")/*LSmile*/
execute ("paramWire.connect $"+g.name+"_Rsquint_ctrl.pos.controller[#X_Position] $"+g.name+".modifiers[#Morpher][10] \"if X_Position<0 then (-X_position*100) else 0\"")/*RSmile*/

--execute ("paramWire.connect $"+g.name+"_LSmile_LFrown_ctrl.pos.controller[#Z_Position] $"+g.name+".modifiers[#Morpher][11] \"if Z_Position<0 then (-Z_position*100) else 0 \"")/*LFrown*/
--execute ("paramWire.connect $"+g.name+"_RSmile_RFrown_ctrl.pos.controller[#Z_Position] $"+g.name+".modifiers[#Morpher][12] \"if Z_Position<0 then (-Z_position*100) else 0 \"")/*RFrown*/

execute ("paramWire.connect $"+g.name+"_Lsquint_ctrl.pos.controller[#X_Position] $"+g.name+".modifiers[#Morpher][11] \"if X_Position<0 then (-X_position*100) else 0\"")/*LFrown*/
execute ("paramWire.connect $"+g.name+"_Rsquint_ctrl.pos.controller[#X_Position] $"+g.name+".modifiers[#Morpher][12] \"if X_Position>0 then (X_position*100) else 0\"")/*RFrown*/


--execute ("paramWire.connect $"+g.name+"_LSmile_LFrown_ctrl.pos.controller[#Z_Position] $"+g.name+".modifiers[#Morpher][11] \"if Z_Position<0 then (-Z_position*100) else 0 \"")/*LFrown*/
--execute ("paramWire.connect $"+g.name+"_RSmile_RFrown_ctrl.pos.controller[#Z_Position] $"+g.name+".modifiers[#Morpher][12] \"if Z_Position<0 then (-Z_position*100) else 0 \"")/*RFrown*/

--execute ("paramWire.connect $"+g.name+"_Jaw_Fwd_ctrl.pos.controller[#Z_Position] $"+g.name+".modifiers[#Morpher][13] \"Z_Position*100\"")/*JawFwd*/
--execute ("paramWire.connect $"+g.name+"_Jaw_open_ctrl.pos.controller[#Z_Position] $"+g.name+".modifiers[#Morpher][14] \"Z_Position*100\"")/*JawOpen*/

execute ("paramWire.connect $"+g.name+"_Jaw_open_ctrl.pos.controller[#X_Position] $"+g.name+".modifiers[#Morpher][13] \"if X_Position > 0 then X_Position*100 else 0 \"")/*JawWide*/
execute ("paramWire.connect $"+g.name+"_Jaw_open_ctrl.pos.controller[#X_Position] $"+g.name+".modifiers[#Morpher][14] \"if X_Position < 0 then -X_Position*100 else 0\"")/*Narrow*/
--execute ("paramWire.connect $"+g.name+"_Jaw_open_ctrl.pos.controller[#Z_Position] $"+g.name+".modifiers[#Morpher][15] \"if Z_Position > 0 then Z_Position*100 else 0\"")/*JawFwd*/
execute ("paramWire.connect $"+g.name+"_Reye_cls_ctrl.pos.controller[#Z_Position] $"+g.name+".modifiers[#Morpher][15] \"if Z_Position < 0 then -Z_Position*100 else 0 \"")/*ReyeClose*/
execute ("paramWire.connect $"+g.name+"_Leye_cls_ctrl.pos.controller[#Z_Position] $"+g.name+".modifiers[#Morpher][16] \"if Z_Position < 0 then -Z_Position*100 else 0\"")/*LeyeClose*/

execute ("paramWire.connect $"+g.name+"_Jaw_open_ctrl.pos.controller[#Z_Position] $"+g.name+"_BoneJaw.rotation.controller[#Z_Rotation] \"if Z_Position < 0 then (Z_Position) else 0\"")/*JawOpen*/
execute ("paramWire.connect $"+g.name+"_Jaw_Fwd_ctrl.pos.controller[#X_Position] $"+g.name+"_BoneJaw.rotation.controller[#Y_Rotation] \"X_Position\"")/*JawOpen*/
)


	

