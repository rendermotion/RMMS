ca=attributes PickerAttributes 
(
Parameters Memory rollout:Picker
	(
		LinkItems  Type:#nodeTab tabSizeVariable:TRUE 
		LinkNames Type:#stringTab tabSizeVariable:TRUE
		LinkInfo Type:#stringTab tabSizeVariable:TRUE
	)
rollout Picker "LinkControls" width:168 height:368
(
	
	fn convierte=(
			LinkNames=#()
			for i in LinkItems do
			append LinkNames i.name
			return LinkNames
			)
	
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
	fn rewriteinfo=(
		NumTargets=$.controller.getNumTargets()
		LinkInfo=#()
		for n=1 to NumTargets do 
			(
			currentNode=$.controller.getNode n
			if currentNode!=undefined then  
				(
					append LinkInfo ((($.controller.getFrameNo n)as string)+"  "+currentNode.name)
				)
			else
				append LinkInfo  ((($.controller.getFrameNo n)as string)+" World  ")
			) 
	return LinkInfo
	)
	button DelLnkObj "Delete Link Object" pos:[24,8] width:120 height:16 toolTip:"Deletes from the list a link object"
	pickbutton btn1 "AddLinkObject" pos:[24,32] width:120 height:24 toolTip:"Adds an Item to the Objects List"
	listbox Padres "Objects" pos:[24,64] width:120 height:5  items:(LinkNames as array)
	button BtnLink "LinkToObject" pos:[32,160] width:104 height:24 toolTip:"Link an object  in the current Frame"
	button btnLnkWrld "LinkToWorld" pos:[32,186] width:104 height:24 toolTip:"Links To the World in the current Frame"
	button BtnDelLnk "DeleteLink" pos:[32,212] width:104 height:24 toolTip:"Deletes the selected link Key frame"
	groupBox grp1 "Frame  Linked Object" pos:[17,240] width:136 height:96
	listbox InfoTxt "" pos:[24,258] width:120 height:5  items:(LinkInfo as array)
	on DelLnkObj pressed do
		(
		  if queryBox ("Do you wish to delete " +LinkNames[Padres.selection] +  " Object From the list?" ) do 
			(
			deleteItem    LinkItems  Padres.selection
			Padres.items =(convierte())as array
			)
		)
	on btn1 picked obj do
	(
	if (GetArrayNum LinkItems obj)==0 do 
		( if obj!=$ do
			(
			append LinkItems obj
			Padres.items=(convierte() as array)
			)
		)
	)
	on BtnLink pressed do
	(
	if (Padres.selection != 0) do
		(
		$.controller.addTarget LinkItems[Padres.selection] currentTime
		InfoTxt.items=(rewriteinfo())as array
		)
	)
	
	on btnLnkWrld pressed do
	(
		$.controller.addWorld frameNo:currentTime
		InfoTxt.items=(rewriteinfo())as array
	)
	on BtnDelLnk pressed do
	(
	$.controller.DeleteTarget	 InfoTxt.selection
	InfoTxt.items=(rewriteinfo())as array
	)
/***********************************************/
on Picker open do (
	NItem=LinkItems.count
	while(NItem>0) do(
		if LinkItems[NItem]==undefined do 
				deleteitem LinkItems NItem
		NItem=NItem-1;
		)
	Padres.items=(convierte() as array)
	)
)
)
$.controller=Link_constraint();

if ($.modifiers[#AttributeHolder]==undefined) then
	(
	AttributeHolder=EmptyModifier()
	addmodifier $ AttributeHolder	
	)
else 
	AttributeHolder=$.modifiers[#AttributeHolder]
CustAttributes.add  AttributeHolder ca

