objectDeformed=selection[2]
ObjectOriginal=selection[1]
a=copy ObjectOriginal
M=morpher()
addmodifier a m
WM3_MC_BuildFromNode M 1 ObjectDeformed
addmodifier a (mirror())
a.position=ObjectOriginal.position
b=copy ObjectOriginal
Def=skin_wrap()
Def.falloff =.5
Def.Distance=0.25
addmodifier b Def
Def.meshList=#(a)
a.Morpher[1].value=100
convertTo b Editable_Poly
delete a
b.position.y=objectDeformed.position.y