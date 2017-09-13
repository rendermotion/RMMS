rendername=(renderers.current)as string
Tokens=filterString rendername "_";
if Tokens[1]=="V" and  Tokens[2]=="Ray" do
(
	renderers.current.gi_on=true
	renderers.current.gi_primary_type=0
	renderers.current.gi_secondary_type=3
	renderers.current.gi_irradmap_preset=1
	renderers.current.gi_irradmap_showCalcPhase=true
	renderers.current.lightcache_showCalcPhase=1
	renderers.current.imageSampler_type=1
 )