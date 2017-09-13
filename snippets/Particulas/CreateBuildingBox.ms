j=selection as array
ObjMinX=j[1].min.x
ObjMaxX=j[1].max.x
ValMinY=j[1].min.y
ValMaxY=j[1].max.y
ValMinZ=j[1].min.z
ValMaxZ=j[1].min.z

for i in j do 
(
 if (ObjMinX > i.min.x) do
	  ObjMinX = i.min.x;
if ObjMaxX < (i.max.x) do
	  ObjMaxX=i.max.x
if ValMinY > (i.min.y) do
	  ValMinY=i.min.y
if ValMaxY<(i.max.y) do
	  ValMaxY=i.max.y
if ValMinZ>(i.min.z) do
	  ValMinZ=i.min.z
if ValMaxZ<(i.max.z) do
	  ValMaxz=i.max.z
 )
 Vheight=ValMaxZ-ValMinZ
 Vlength=ValMaxY-ValMinY
 Vwidth=ObjMaxX-ObjMinX
 NewBox = box height:Vheight width:Vwidth length:Vlength lengthsegs:15 widthsegs:15 heightsegs:15

 NewBox.position.x=ObjMinX + Vwidth/2
 NewBox.position.y=ValMinY + Vlength/2
 NewBox.position.z=ValMinZ