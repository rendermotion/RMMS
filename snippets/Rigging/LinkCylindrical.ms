
fn Rayo Dobj DSurf =
			(
				Dray = ray Dobj.pos Dobj.dir
				DIntersect = intersectRayex DSurf Dray
				return  DIntersect
			)
fn BindtoSurf  J BindSurf d=
		(
			d.position.controller = attachment()
			d.position.controller.node = BindSurf
			addnewkey d.position.controller 0
			k = attachctrl.getkey d.position.controller 1
			k.face = J[2]
			k.coord = J[3]
		)
fn rotatePoint a =
(	
	prevpos=a.position
	a.position=[0,0,0]
		in coordsys world a.rotation =eulerAngles 0 90 0
	a.position=prevpos
	
	if (a.position.x>0) then 
	if (a.position.y>0) then 
		rotz=-atan (a.pos.y/a.pos.x)
	else
		rotz=-atan (a.pos.y/a.pos.x)
else 
		if (a.position.y>0) then 
			rotz=180-atan(a.pos.y/a.pos.x)
		else 
			rotz=-180-atan(a.pos.y/a.pos.x)
print ("rotz " + (rotz as string))
in coordsys local a.rotation =eulerAngles (180+rotz) 0 0 
)

BindObject=$Cylinder02
d = Point size:2 centermarker:true axistripod:false cross:false box:false constantscreensize:false drawontop:false

for i in selection do
		(
		d = Point size:2 centermarker:true axistripod:false cross:false box:false constantscreensize:false drawontop:false
		d.position = i.position
		rotatePoint d
		j=rayo d BindObject
		BindtoSurf j BindObject d
		i.parent=d
		)
