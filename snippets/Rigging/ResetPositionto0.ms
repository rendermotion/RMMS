ObjSelect=selection as array
NSelect=ObjSelect.count
for i=1 to NSelect do 
(
a=Box();
Convertto a Editable_Poly
a.name=ObjSelect[(NSelect-i)+1].name
a.parent=ObjSelect[(NSelect-i)+1].parent
a.EditablePoly.attach ObjSelect[(NSelect-i)+1] a
--select a
a.EditablePoly.SetSelection #Face #{1..6}
a.EditablePoly.delete #Face
)