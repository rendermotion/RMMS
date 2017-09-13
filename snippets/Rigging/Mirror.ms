rollout Espejo "Mirror" width:162 height:300
		(
			groupBox Mir "Mirrors Config" pos:[8,8] width:210 height:150
			label lbl2 "Seleccionar el objeto original .\nAgrega a la seleccion el objeto mirror.\nPresiona un boton" pos:[16,24] width:200 height:140
			groupBox bot "" pos:[8,150] width:210 height:120
			button bm " Mirror o_-   o_o" pos:[16,170] width:90 height:18
			button bmn "Mirror o_-  -_o" pos:[120,170] width:90 height:18
			label lab1"falloff" pos:[16,195]
			label lab2"Distance" pos:[110,195]
			
			checkbox chk1 "FaceMode" pos:[50,130] width:101 height:16
			
			spinner spn1 "" pos:[55,195] width:48 height:16 scale:.01 type:#float fieldwidth:40 range:[0,10,0.01]
			spinner spn2 "" pos:[160,195] width:48 height:16 scale:.01 type:#float fieldwidth:40 range:[0,10,0.01]
			
			on bm pressed do
			(
				ObjectDeformed=selection[2]
				ObjectOriginal=selection[1]
				a=snapshot ObjectOriginal
				M=morpher()
				addmodifier a M
				WM3_MC_BuildFromNode M 1 ObjectDeformed
				addmodifier a (mirror())
				a.position=ObjectDeformed.position
				b=snapshot ObjectDeformed
				Def=skin_wrap()
				if chk1==true then 
					def.Engine = 0
				else 
					def.Engine = 1
				addmodifier b Def
				Def.meshList=#(a)
				Def.falloff =spn1.value
				Def.Distance=spn2.value
				
				set animate on
						sliderTime = 5f
				WM3_MC_SetValue a.Morpher 1 100.0;
				set animate off
					sliderTime = 0f;
					sliderTime = 5f;
				a.Morpher.Autoload_of_targets=1;
				convertTo b Editable_Poly
				delete a
				sliderTime = 0f;
			)
			on bmn pressed do
			(
				ObjectDeformed=selection[2];
				ObjectOriginal=selection[1];

				a=snapshot ObjectOriginal

				addmodifier a (morpher());
				WM3_MC_BuildFromNode a.Morpher 1 ObjectDeformed;
				addmodifier a (mirror());

				a.position=ObjectOriginal.position;

				b=snapshot ObjectOriginal

				addmodifier b (skin_wrap());
				if chk1==true then
					b.skin_wrap.engine=0
				else
					b.skin_wrap.engine=1
				
				b.skin_wrap.meshList=#(a);
				b.skin_wrap.falloff = spn1.value
				b.skin_wrap.Distance=spn2.value
				a.Morpher.Autoload_of_targets=1;
				set animate on
						sliderTime = 5f
						WM3_MC_SetValue a.Morpher 1 100.0;
				set animate off
					sliderTime = 0f;
					sliderTime = 5f;
				convertTo b Editable_Poly;
				delete a;
				b.position.y=ObjectDeformed.position.y;
				sliderTime = 0f		
			)
			hyperlink rm "www.Rendermotion.com" address:"www.rendermotion.com" color:(color 179 122 181) hovercolor:(color 145 39 143) visitedcolor:(color 179 122 181) align:#center pos:[55,230]
		)
		createdialog espejo 220 250