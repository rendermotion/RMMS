a=#($GraficaPuntos04,$GraficaPuntos06,$GraficaPuntos07,$GraficaPuntos08,$GraficaPuntos09,$GraficaPuntos10,$GraficaPuntos11,$GraficaPuntos12,$GraficaPuntos13,$GraficaPuntos14,$GraficaPuntos15,$GraficaPuntos16,$GraficaPuntos17,$GraficaPuntos18,$GraficaPuntos19,$GraficaPuntos20,$GraficaPuntos21,$GraficaPuntos22,$GraficaPuntos23,$GraficaPuntos24,$GraficaPuntos25,$GraficaPuntos26,$GraficaPuntos27,$GraficaPuntos28,$GraficaPuntos29,$GraficaPuntos30,$GraficaPuntos31,$GraficaPuntos32,$GraficaPuntos33,$GraficaPuntos34,$GraficaPuntos35,$GraficaPuntos36,$GraficaPuntos37,$GraficaPuntos38,$GraficaPuntos39,$GraficaPuntos40,$GraficaPuntos41,$GraficaPuntos42,$GraficaPuntos43,$GraficaPuntos44,$GraficaPuntos45,$GraficaPuntos46,$GraficaPuntos47,$GraficaPuntos48,$GraficaPuntos49,$GraficaPuntos50,$GraficaPuntos51,$GraficaPuntos52,$GraficaPuntos53,$GraficaPuntos54,$GraficaPuntos55,$GraficaPuntos56,$GraficaPuntos57,$GraficaPuntos05,$GraficaPuntos65,$GraficaPuntos64,$GraficaPuntos63,$GraficaPuntos66,$GraficaPuntos60,$GraficaPuntos119,$GraficaPuntos01,$GraficaPuntos58,$GraficaPuntos67,$GraficaPuntos68,$GraficaPuntos69,$GraficaPuntos70,$GraficaPuntos71,$GraficaPuntos72,$GraficaPuntos73,$GraficaPuntos74,$GraficaPuntos75,$GraficaPuntos76,$GraficaPuntos77,$GraficaPuntos78,$GraficaPuntos79,$GraficaPuntos80,$GraficaPuntos81,$GraficaPuntos82,$GraficaPuntos83,$GraficaPuntos84,$GraficaPuntos85,$GraficaPuntos86,$GraficaPuntos87,$GraficaPuntos88,$GraficaPuntos89,$GraficaPuntos90,$GraficaPuntos91,$GraficaPuntos92,$GraficaPuntos93,$GraficaPuntos94,$GraficaPuntos95,$GraficaPuntos96,$GraficaPuntos97,$GraficaPuntos98,$GraficaPuntos99,$GraficaPuntos100,$GraficaPuntos101,$GraficaPuntos102,$GraficaPuntos103,$GraficaPuntos104,$GraficaPuntos105,$GraficaPuntos106,$GraficaPuntos107,$GraficaPuntos108,$GraficaPuntos109,$GraficaPuntos110,$GraficaPuntos111,$GraficaPuntos112,$GraficaPuntos113,$GraficaPuntos114,$GraficaPuntos115,$GraficaPuntos116,$GraficaPuntos117,$GraficaPuntos118,$GraficaPuntos62,$GraficaPuntos61,$GraficaPuntos03,$GraficaPuntos02,$GraficaPuntos59,$GraficaPuntos120);
Umbral=5;
for i in a do
	(
	 if  i.Position.x > $Dummy_Control.Position.x then 
	    (
		 i.visibility=(float)0)
	  else
			(
			if i.Position.x < $Dummy_Control.Position.x-Umbral then
				(
				 i.visibility = (float)1
				)
			else 
				(
				 i.visibility = (float)(($Dummy_Control.Position.x-i.Position.x)/Umbral)
				)
			)
	 i.visibility=1
	 )