a = getMeditMaterial 1;
map=a.diffuseMap;
zpos=in coordsys local $point01.pos.z
T=currentTime;
if (zpos>50)then
	(
	val=50;
	)
else(
	if (zpos<-50)then
		(
		val=-50
		)
	else val=(int)zpos
	 )
val=val+50;
map.starttime=T-val;
0;
