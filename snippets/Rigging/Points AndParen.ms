/*for i in selection do 
 (
	a=point()
	 a.size=3
	 a.transform=i.transform
	 i.parent=a
  )*/

for i in selection do 
 (
	a=point()
	 a.size=3
	 a.position=i.position
	 i.parent=a
  )
  