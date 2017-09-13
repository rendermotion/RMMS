objectDeformed=selection[2]
ObjectOriginal=selection[1]
a=snapshot ObjectOriginal
M=morpher()
addmodifier a m
WM3_MC_BuildFromNode M 1 ObjectDeformed
addmodifier a (mirror())
a.position=ObjectDeformed.position
b=snapshot ObjectDeformed
Def=skin_wrap()
addmodifier b Def
Def.meshList=#(a)
Def.falloff =.5
Def.Distance=0.25
a.Morpher[1].value=100
convertTo b Editable_Poly
delete a




