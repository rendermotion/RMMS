setGroupOpen $GrupoHairColon TRUE
select $ColonHair01
Cntrller = $ColonHair01.Ripple.phase.Controller;
llaves=Cntrller.keys
for i in llaves do
(	
	t=i.time
	Valor=i.value
	format "t=%i Valor=%i " t Valor
	
)
setGroupOpen $GrupoHairColon FALSE