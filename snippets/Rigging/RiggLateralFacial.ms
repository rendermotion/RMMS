fn existeMorpher a=
	(
		if a.modifiers["Morpher"]!=undefined then
				return true
		else 
				return false;
	)
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
fn LinkM CharacterOrig Names Cntrls=(
	select CharacterOrig
	if (existeMorpher CharacterOrig==False) do
		(
			addmodifier  CharacterOrig (Morpher())
			n=1
			for i in Names do
				(
						print ("Pone Morphers"+i  as string)
						WM3_MC_BuildFromNode CharacterOrig.modifiers["Morpher"]  n  (execute("$"+i))
						n=n+1;
				)
		)
for j=1 to 8 do 
		(
		ScriptControllerVar=float_script()
		ScriptControllerVar.AddTarget "ControlOjoMain"  $Reye_cls_Lateral_ctrl.position.z_position.controller
		F=("ScriptControllerVar.AddTarget \"ControlCara\" "+" $"+Cntrls[j] +".position.z_position.controller")
		execute F
		ScriptControllerVar.script="0"		
		Script02ControllerVar=copy ScriptControllerVar
		Script03ControllerVar=copy ScriptControllerVar
		Script04ControllerVar=copy ScriptControllerVar
		Script05ControllerVar=copy ScriptControllerVar
		
		CharacterOrig.modifiers[#Morpher][(NumMorpher CharacterOrig Names[5*(j-1)+1])].controller=ScriptControllerVar
		ScriptControllerVar.script=("ControlCara*100\n")
		CharacterOrig.modifiers[#Morpher][(NumMorpher CharacterOrig Names[5*(j-1)+2])].controller=Script02ControllerVar
		Script02ControllerVar.script=("ControlCara*(1-ControlOjoMain)*100\n")
		CharacterOrig.modifiers[#Morpher][(NumMorpher CharacterOrig Names[5*(j-1)+3])].controller=Script03ControllerVar
		Script03ControllerVar.script=("ControlCara*100\n")	
		CharacterOrig.modifiers[#Morpher][(NumMorpher CharacterOrig Names[5*(j-1)+4])].controller=Script04ControllerVar
		Script04ControllerVar.script=("ControlCara*(1-ControlOjoMain)*100\n")
		CharacterOrig.modifiers[#Morpher][(NumMorpher CharacterOrig Names[5*(j-1)+5])].controller=Script05ControllerVar
		Script05ControllerVar.script=("ControlCara*100\n")
		)
		
	execute ("paramWire.connect $"+"Reye_cls_Lateral_ctrl"+".pos.controller[#Z_Position] $"+CharacterOrig.name+".modifiers[#Morpher]["+ (NumMorpher CharacterOrig "rightEyeCls" )as string +"] \"if Z_Position>0 then Z_Position*100 else 0\" ") 
	execute ("paramWire.connect $"+"Reye_cls_Lateral_ctrl"+".pos.controller[#Z_Position] $"+CharacterOrig.name+".modifiers[#Morpher]["+ (NumMorpher CharacterOrig "leftEyecls" )as string +"] \"if Z_Position>0 then Z_Position*100 else 0\" ") 
		
)
fn LinkTeeth CharacterOrig TeethOrig Names Cntrls Teeth=(
	select TeethOrig
	if (existeMorpher TeethOrig==False) do
		(
			addmodifier  TeethOrig (Morpher())
			n=1
			for i in Teeth do
				(
						WM3_MC_BuildFromNode TeethOrig.modifiers["Morpher"]  n  (execute("$"+i))
						n=n+1;
				)
		)
	execute ("paramWire.connect $"+CharacterOrig.name+".modifiers[#Morpher]["+(NumMorpher CharacterOrig "Exp1_Mouth") as string +"] $"+TeethOrig.name+".modifiers[#Morpher]["+ (NumMorpher TeethOrig "Teeth_Exp01") as string +"] \""+ (substituteString ((CharacterOrig.modifiers[#Morpher][(NumMorpher CharacterOrig "Exp1_Mouth")])as string) "SubAnim:" "")+"_" +"\" ")
	execute ("paramWire.connect $"+CharacterOrig.name+".modifiers[#Morpher]["+(NumMorpher CharacterOrig "Exp2_Mouth") as string +"] $"+TeethOrig.name+".modifiers[#Morpher]["+ (NumMorpher TeethOrig "Teeth_Exp02") as string +"] \""+ (substituteString ((CharacterOrig.modifiers[#Morpher][(NumMorpher CharacterOrig "Exp2_Mouth")])as string) "SubAnim:" "")+"_" +"\" ")
	execute ("paramWire.connect $"+CharacterOrig.name+".modifiers[#Morpher]["+(NumMorpher CharacterOrig "Exp7_Mouth") as string +"] $"+TeethOrig.name+".modifiers[#Morpher]["+ (NumMorpher TeethOrig "Teeth_Exp07") as string +"] \""+ (substituteString ((CharacterOrig.modifiers[#Morpher][(NumMorpher CharacterOrig "Exp7_Mouth")])as string) "SubAnim:" "")+"_" +"\" ")
	execute ("paramWire.connect $"+CharacterOrig.name+".modifiers[#Morpher]["+(NumMorpher CharacterOrig "Exp8_Mouth") as string +"] $"+TeethOrig.name+".modifiers[#Morpher]["+ (NumMorpher TeethOrig "Teeth_Exp08") as string +"] \""+ (substituteString ((CharacterOrig.modifiers[#Morpher][(NumMorpher CharacterOrig "Exp8_Mouth")])as string) "SubAnim:" "")+"_" +"\" ")
)


fn ligaMorphers =(
local Cntrls=#("CaraControl01","CaraControl02","CaraControl03","CaraControl04","CaraControl05","CaraControl06","CaraControl07","CaraControl08","CaraControl09","Reye_cls_Lateral_ctrl");
local Names=#(
"Left_Eyebrow_Up_Eyebrow",
"Left_Eyebrow_Up_Eye",
"Right_Eyebrow_Up_Eyebrow",
"Right_Eyebrow_Up_Eye",
"Exp1_Mouth",

"Left_Eyebrow_OutDown_Eyebrow",
"Left_Eyebrow_OutDown_Eye",
"Right_Eyebrow_OutDown_Eyebrow",
"Right_Eyebrow_OutDown_Eye",
"Exp2_Mouth",

"Left_Eyebrow_Exp3_Eyebrow",
"Left_Eyebrow_Exp3_Eye",
"Right_Eyebrow_Exp3_Eyebrow",
"Right_Eyebrow_Exp3_Eye",
"Exp3_Mouth",

"Left_Eyebrow_Exp4_Eyebrow",
"Left_Eyebrow_Exp4_Eye",
"Right_Eyebrow_Exp4_Eyebrow",
"Right_Eyebrow_Exp4_Eye",
"Exp4_Mouth",

"Left_Eyebrow_Exp5_Eyebrow",
"Left_Eyebrow_Exp5_Eye",
"Right_Eyebrow_Exp5_Eyebrow",
"Right_Eyebrow_Exp5_Eye",
"Exp5_Mouth",

"Left_Eyebrow_Exp6_Eyebrow",
"Left_Eyebrow_Exp6_Eye",
"Right_Eyebrow_Exp6_Eyebrow",
"Right_Eyebrow_Exp6_Eye",
"Exp6_Mouth",

"Left_Eyebrow_Exp7_Eyebrow",
"Left_Eyebrow_Exp7_Eye",
"Right_Eyebrow_Exp7_Eyebrow",
"Right_Eyebrow_Exp7_Eye",
"Exp7_Mouth",

"Left_Eyebrow_Exp8_Eyebrow",
"Left_Eyebrow_Exp8_Eye",
"Right_Eyebrow_Exp8_Eyebrow",
"Right_Eyebrow_Exp8_Eye",
"Exp8_Mouth",
"rightEyeCls","leftEyecls","CorreccionOjo","Exp9_Mouth");
local teeth=#("Teeth_Exp01","Teeth_Exp02","Teeth_Exp07","Teeth_Exp08")

F=checaMorphers Names

G=checaMorphers Cntrls
H=checaMorphers teeth
print (F +G +"Se encontraron")
if F=="OK" and G=="OK" and H=="OK" do 
	(
	LinkM $Character Names Cntrls
	LinkTeeth $character $Teeth_Dn Names Cntrls Teeth	
	)
)
ligaMorphers();
