for i in selection do 
(
a=Box();
Convertto a Editable_Poly
a.rotation=i.rotation
a.position=i.position
a.name=i.name
a.EditablePoly.attach i a
--select a
a.EditablePoly.SetSelection #Face #{1..6}
a.EditablePoly.delete #Face
)