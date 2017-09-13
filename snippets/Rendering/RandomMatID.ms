$.modifiers[1].selectMode=1

EditPolyMod.SetEPolySelLevel $.modifiers[#Edit_Poly] #Element
EditPolyMod.select $.modifiers[#Edit_Poly] #CurrentLevel  #{1}
EditPolyMod.convertSelection $.modifiers[#Edit_Poly] #Face #Element
SelArray=EditPolyMod.GetSelection  $.modifiers[#Edit_Poly] #Face
showproperties f
f=$.modifiers[#Edit_Poly]
showproperties f
f.currentOperation   70
--$.modifiers[#Edit_Poly].materialIDToSet   2
--AllreadySelected=copy SelArray
/*
do(
g=1
for i=1 to AllreadySelected.count while (not ((findItem AllreadySelected i)==0)) do
			(g=g+1)
print g
	
)while (AllreadySelected.numberSet != AllreadySelected.count)*/
