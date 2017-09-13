if currentTime==0 do 
	global s=#($wave434,$wave655,$wave747,$wave774,$wave968,$wave1157,$wave1416,$wave1658,$wave1828,$wave2611,$wave2867,$wave2868,$wave2869,$wave2870,$wave3007,$wave3008,$wave3009,$wave3010,$wave3147,$wave3148,$wave3149,$wave3150,$wave3489,$wave3809,$wave4216,$wave4304,$wave4768,$wave4849,$wave5118,$wave5173,$wave5232,$wave5356,$wave5438);
colapstime=116;
defpos=200;
T=30 --en frames
stop_hight=15
st=3;
st2=2.3;
st3=4;
long=50--mientrasmasw grande disminuye el efecto de el sen x/x
long2=30
long3=25
if currentTime<colapstime then
	for i in s do
		(
		len1=sqrt((($AnimDummy01.pos.y-i.pos.y))^2+(($AnimDummy01.pos.x-i.pos.x))^2);
		len2=sqrt((($AnimDummy02.pos.y-i.pos.y))^2+(($AnimDummy02.pos.x-i.pos.x))^2);
		len3=sqrt((($AnimDummy03.pos.y-i.pos.y))^2+(($AnimDummy03.pos.x-i.pos.x))^2);
		i.pos.z=defpos + st *sin(180*currentTime/T +len1*180/40)/(1+len1/long)
		i.pos.z=i.pos.z+ st2*sin(180*currentTime/15+len1*180/50)/(1+len2/long2)
		i.pos.z=i.pos.z+ st3*sin(180*currentTime/20+len1*180/60)/(1+len3/long3)
		)

		
		
else
if currentTime==colapstime then
	(
	global vel=#();
	global real_vel=#();
	aux=1;
	seed(234)
	for i in s do
		(
		real_vel[aux]=0;
		vel[aux]=random 8.0  13
		aux+=1;
		)
	)
else
if currentTime >colapstime do
	(
	aux=1;
	for i in s do
		(
		if  vel[aux]>0 do
			(
			if real_vel[aux]>vel[aux] and i.pos.z>stop_hight then
				real_vel[aux]=vel[aux]
			else 
				if i.pos.z>stop_hight do
					real_vel[aux]=real_vel[aux]+vel[aux]/10
			if i.pos.z>0 and i.pos.z<=stop_hight do
				real_vel[aux]=i.pos.z/15+1

			i.pos.z=i.pos.z-real_vel[aux]

			if  i.pos.z<0 do
				(
				 i.pos.z=0
				 vel[aux]=0
				 real_vel[aux]=0
				)
			)
		aux+=1;
		)
	)