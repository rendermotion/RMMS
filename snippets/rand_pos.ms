minx=-3;
maxx=3;
miny=-3;
maxy=3;
minz=0;
maxz=0;
minangx=-5;
maxangx=5;
minangy=-5;
maxangy=5;
minangz=0;
maxangz=360;
for i in selection do
(
 xnpos=random minx maxx
 ynpos=random miny maxy
 znpos=random minz maxz

 move i [xnpos,ynpos,znpos]
g = random .7  1.2
 i.scale =  [g , g , g] 

 angx=random minangx  maxangx
 angy=random minangy  maxangy
 angz=random minangz  maxangz
 an=eulerangles  angx angy angz
 rotate i an


)
 


