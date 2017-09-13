--E-Light_MAX5.ms
--E-Light 1.02
--16 January 2003
--"Environment Light" for 3D Studio MAX 3/4/5
--This script generates a geosphere with lights on its vertices. The lights can be coloured using a bitmap. The settings let you create a lightdome that simulates complex environment light.
--Use at own risk!
--NOT FOR COMMERCIAL USE!
--Written by Ronnie Olsthoorn
--Contact: skyraider3d@hotmail.com
--Website: http://www.skyraider3d.com

--Version Information--
-----------------------
--Version 1.01 - 15 January 2003
--Added measure to stop screen redraw during light build process
--Made different versions for MAX 3/4 and MAX 5 due to interface layout issues
--
--Version 1.02 - 16 January 2003
--Bitmap cancel bug fixed

--The Script--

--Global Parameters

Global EL_Map = undefined
Global EL_Map_Height = undefined
Global EL_Map_Width = undefined
Global GeosphereHemisphereChecked = on
Global GeospherePosition = [0,0,0]
Global GeosphereRadiusController = bezier_float()
Global GeosphereRadiusValue = 1000.0
Global GeosphereSegmentsValue = 2
Global LightsColorRGB = white
Global LightsCount = 91
Global LightsFalloffValue = 52.0
Global LightsIndex = undefined
Global LightsHotspotValue = 50.0
Global LightsMapBiasValue = 0.1
Global LightsMapSizeValue = 128
Global LightsMemory = 6
Global LightsMultiplierController = bezier_float()
Global LightsMultiplierValue = 1.0
Global LightsNumber = undefined
Global LightsOvershootChecked = off
Global LightsSampleRangeValue = 4.0
Global LightsShadowColorColor = black
Global LightsShadowMultiplierController = bezier_float()
Global LightsShadowMultiplierValue = 1.0
Global LightsShadowChecked = on
Global LightsStatusChecked = on
Global LightsStepValue = 1
Global VertexCount = undefined

--Functions

fn FnTotalNumberOfLights =
	(
	if GeosphereHemisphereChecked then
		(
		LightsCount = ((20 * GeosphereSegmentsValue^2 + 5 * GeosphereSegmentsValue + 1.00)/LightsStepValue)
		LightsCount += 0.99
		)
	else
		(
		LightsCount = ((10 * GeosphereSegmentsValue^2 + 2.00)/LightsStepValue)
		LightsCount += 0.99
		)
	LightsMemory = (LightsCount * 4.0 * LightsMapsizeValue^2 / 1024000) + 0.5
	)


--"Total memory required for shadows:" + (LightsCount*4*LightsMapsizeValue^2/1024000 as string)


--Create Rollout

Rollout ELCreate "Create Environment Light"
	(
	Button CreateEL "Create Environment Light!" width:194 align:#center
	On CreateEL pressed do
		(
		if $EL_dome == undefined then
			(
			GeoSphere name:"EL_dome" pos:[0,0,0] radius:GeosphereRadiusValue hemisphere:GeosphereHemisphereChecked segs:GeosphereSegmentsValue mapCoords:on wirecolor:black renderable:off xray:on
			Addmodifier $EL_dome (Mesh_Select())
			VertexCount = getnumverts $EL_dome
			if GeosphereHemisphereChecked then VertexCount += -1
			LightsNumber = #()
			FnTotalNumberOfLights()
			disableSceneRedraw()
			for LightsIndex in 1 to VertexCount by LightsStepValue do
				(
				GeospherePosition = $EL_dome.pos
				VertexPosition = getvert $EL_dome LightsIndex
				LightsNumber[LightsIndex] = TargetSpot hotspot:LightsHotspotValue falloff:LightsFalloffValue overShoot:LightsOvershootChecked decayRadius:LightsStepValue attenDecay:1 raytracedShadows:off pos:VertexPosition enabled:LightsStatusChecked rgb:LightsColorRGB multiplier:(LightsMultiplierValue/(LightsCount as Integer)) castShadows:LightsShadowChecked shadowColor:(LightsShadowColorColor/(LightsCount as Integer)) shadowMultiplier:LightsShadowMultiplierValue mapbias:LightsMapBiasValue mapsize:LightsMapSizeValue samplerange:LightsSampleRangeValue parent:$EL_dome name:(uniquename "EL_light") target:(Targetobject name:(uniquename "EL_target") parent:$EL_dome transform:(matrix3 [1,0,0] [0,1,0] [0,0,1] GeospherePosition))
				)
				enableSceneRedraw()
			if EL_Map != undefined then
				(
				sceneMaterials["EL_dome_material"] = Standardmaterial()
				$EL_dome.material = sceneMaterials["EL_dome_material"]
				sceneMaterials["EL_dome_material"].Diffuse = LightsColorRGB
				sceneMaterials["EL_dome_material"].diffuseMap = Bitmaptexture filename:EL_Map.filename
				VertexCount = getnumverts $EL_dome
				if GeosphereHemisphereChecked then VertexCount += -1
				FnTotalNumberOfLights()
				for LightsIndex in 1 to VertexCount by LightsStepValue do
					(
					UVVert = getTVert $EL_dome LightsIndex
					EL_Map_X = (UVVert.x * EL_Map.width)
					if GeosphereHemisphereChecked then
						(
						EL_Map_Y = abs((2 * (1.0 - UVVert.y) * EL_Map.height) - 0.1)
						)
						else EL_Map_Y = abs(((1.0 - UVVert.y) * EL_Map.height) - 0.1)
					EL_Map_Pixel = getPixels EL_Map [EL_Map_X as integer,EL_Map_Y as integer] 1
					LightsNumber[LightsIndex].rgb = EL_Map_Pixel[1]
					)
				)
			)
			else Messagebox "Environment Light already exists!"
		)
	)

--Lights Rollout

Rollout LightsCreation "Light Settings"
	(
	Group "Light Parameters"
	(
	Checkbox LightsStatus "Enable" checked:on across:2 align:#left offset:[1,0] across:2
	Colorpicker LightsColor "Color:" color:[255,255,255] align:#right offset:[-1,0]
	Spinner LightsStep "Step:" range:[1,100,1] type:#integer align:#left offset:[14,0] width:60 across:2
	Spinner LightsMultiplier "Multiplier:" range:[0,100,1] controller:LightsMultiplierController align:#right width:70 offset:[-1,0]
	Spinner LightsHotspot "Hotspot:" range:[0,1000000000,50.0] scale:1 align:#left width:115 offset:[9,0]
	Spinner LightsFalloff "Falloff:" range:[0,1000000000,52.0] scale:1 align:#right width:115 offset:[15,0] across:2
	Checkbox LightsOvershoot "Overshoot" checked:off align:#right offset:[5,0]
	)
	Group "Shadow Parameters"
	(
	Checkbox LightsShadow "Cast Shadows" checked:on align:#left offset:[1,0] across:2
	Colorpicker LightsShadowColor "Color:" color:[0,0,0] align:#right offset:[-1,0]
	Spinner LightsShadowMultiplier "Density:" range:[0,100,1] controller:LightsShadowMultiplierController align:#left width:71 offset:[20,0] across:2
	Spinner LightsMapSize "Map Size:" range:[1,4096,128] type:#integer align:#right width:71 offset:[-1,0]
	Spinner LightsMapBias "Bias:" range:[0,1000,0.1] align:#left width:52 offset:[15,0] across:2
	Spinner LightsSampleRange "Sample Range:" range:[0.01,50,4.0] align:#right offset:[-1,0] width:88
	)
	Label LabelTotal "Total: 91 Lights (6 Mb)" align:#center
	On LightsStep changed val do
		(
		LightsStepValue = val
		FnTotalNumberOfLights()
		LightsCreation.LabelTotal.text = "Total: " + ((LightsCount as integer) as string) + " Lights (" + ((LightsMemory as integer) as string) + " Mb)"
		if $EL_dome != undefined then
			(		
			VertexCount = getnumverts $EL_dome
			delete $EL_light*
			if GeosphereHemisphereChecked then VertexCount += -1
			LightsNumber = #()
			FnTotalNumberOfLights()
			disableSceneRedraw()
			for LightsIndex in 1 to VertexCount by LightsStepValue do
				(
				GeospherePosition = $EL_dome.pos
				VertexPosition = getvert $EL_dome LightsIndex
				LightsNumber[LightsIndex] = TargetSpot hotspot:LightsHotspotValue falloff:LightsFalloffValue overShoot:LightsOvershootChecked decayRadius:LightsStepValue attenDecay:1 raytracedShadows:off pos:VertexPosition enabled:LightsStatusChecked rgb:LightsColorRGB multiplier:(LightsMultiplierValue/(LightsCount as Integer)) castShadows:LightsShadowChecked shadowColor:(LightsShadowColorColor/(LightsCount as Integer)) shadowMultiplier:LightsShadowMultiplierValue mapbias:LightsMapBiasValue mapsize:LightsMapSizeValue samplerange:LightsSampleRangeValue parent:$EL_dome name:(uniquename "EL_light") target:(Targetobject name:(uniquename "EL_target") parent:$EL_dome transform:(matrix3 [1,0,0] [0,1,0] [0,0,1] GeospherePosition))
				)
				enableSceneRedraw()
			if EL_Map != undefined then
				(
				sceneMaterials["EL_dome_material"] = Standardmaterial()
				$EL_dome.material = sceneMaterials["EL_dome_material"]
				sceneMaterials["EL_dome_material"].Diffuse = LightsColorRGB
				sceneMaterials["EL_dome_material"].diffuseMap = Bitmaptexture filename:EL_Map.filename
				VertexCount = getnumverts $EL_dome
				if GeosphereHemisphereChecked then VertexCount += -1
				FnTotalNumberOfLights()
				for LightsIndex in 1 to VertexCount by LightsStepValue do
					(
					UVVert = getTVert $EL_dome LightsIndex
					EL_Map_X = (UVVert.x * EL_Map.width)
					if GeosphereHemisphereChecked then
						(
						EL_Map_Y = abs((2 * (1.0 - UVVert.y) * EL_Map.height) - 0.1)
						)
						else EL_Map_Y = abs(((1.0 - UVVert.y) * EL_Map.height) - 0.1)
					EL_Map_Pixel = getPixels EL_Map [EL_Map_X as integer,EL_Map_Y as integer] 1
					LightsNumber[LightsIndex].rgb = EL_Map_Pixel[1]
					)
				)
			)
		)	On LightsStatus changed val do
		(
		LightsStatusChecked = val
		if $EL_light01 != undefined then
			(
			for LightsIndex in 1 to VertexCount by LightsStepValue do
				(
				LightsNumber[LightsIndex].baseobject.Enabled = LightsStatusChecked
				)
			)
		)
	on LightsColor changed val do
		(
		LightsColorRGB = val
		if $EL_light01 != undefined then
			(
			for LightsIndex in 1 to VertexCount by LightsStepValue do
				(
				LightsNumber[LightsIndex].baseobject.rgb = LightsColorRGB
				)
			)
		)
	on LightsMultiplier changed val do
		(
		LightsMultiplierValue = val
		if $EL_light01 != undefined then
			(
			FnTotalNumberOfLights()
			for LightsIndex in 1 to VertexCount by LightsStepValue do
				(
				LightsNumber[LightsIndex].baseobject.multiplier = LightsMultiplierValue/(LightsCount as integer)
				)
			LightsMultiplierController.value = ($EL_Light01.baseobject.multiplier*(LightsCount as Integer))
			)
		)
	On LightsShadow changed val do
		(
		LightsShadowChecked = val
		if $EL_light01 != undefined then
			(
			for LightsIndex in 1 to VertexCount by LightsStepValue do
				(
				LightsNumber[LightsIndex].baseobject.castShadows = LightsShadowChecked
				)
			)
		)
	on LightsShadowColor changed val do
		(
		LightsShadowColorColor = val
		if $EL_light01 != undefined then
			(
			FnTotalNumberOfLights()
			for LightsIndex in 1 to VertexCount by LightsStepValue do
				(
				LightsNumber[LightsIndex].baseobject.shadowColor = (LightsShadowColorColor/(LightsCount as integer))
				)
			)
		)
	on LightsShadowMultiplier changed val do
		(
		LightsShadowMultiplierValue = val
		if $EL_light01 != undefined then
			(
			for LightsIndex in 1 to VertexCount by LightsStepValue do
 				(
				LightsNumber[LightsIndex].baseobject.shadowMultiplier = LightsShadowMultiplierValue
				)
			LightsShadowMultiplierController.value = $EL_light01.baseobject.shadowMultiplier
			)
		)
	on LightsMapBias changed val do
		(
		LightsMapBiasValue = val
		if $EL_light01 != undefined then
			(
			for LightsIndex in 1 to VertexCount by LightsStepValue do
 				(
				LightsNumber[LightsIndex].baseobject.mapbias = LightsMapBiasValue
				)
			)
		)
	on LightsMapSize changed val do
		(
		LightsMapSizeValue = val
		FnTotalNumberOfLights()
		LightsCreation.LabelTotal.text = "Total: " + ((LightsCount as integer) as string) + " Lights (" + ((LightsMemory as integer) as string) + " Mb)"
		if $EL_light01 != undefined then
			(
			for LightsIndex in 1 to VertexCount by LightsStepValue do
 				(
				LightsNumber[LightsIndex].baseobject.mapsize = LightsMapSizeValue
				)
			)
		)
	on LightsSampleRange changed val do
		(
		LightsSampleRangeValue = val
		if $EL_light01 != undefined then
			(
			for LightsIndex in 1 to VertexCount by LightsStepValue do
 				(
				LightsNumber[LightsIndex].baseobject.samplerange = LightsSampleRangeValue
				)
			)
		)
	on LightsHotspot changed val do
		(
		LightsHotspotValue = val
		if (LightsHotspotValue + 2) >= LightsFalloffValue then
			(
			LightsFalloffValue = (LightsHotspotValue + 2)
			LightsFalloff.value = LightsFalloffValue
			)
		if $EL_light01 != undefined then
			(
			for LightsIndex in 1 to VertexCount by LightsStepValue do
 				(
				LightsNumber[LightsIndex].baseobject.hotspot = LightsHotspotValue
				if (LightsNumber[LightsIndex].baseobject.hotspot + 2) >= LightsFalloffValue then
					(
					LightsNumber[LightsIndex].baseobject.falloff = LightsFalloffValue
					)
				)
			)
		)
	on LightsFalloff changed val do
		(
		LightsFalloffValue = val
		if (LightsFalloffValue - 2) <= LightsHotspotValue then
			(
			LightsHotspotValue = (LightsFalloffValue - 2)
			LightsHotspot.value = LightsHotspotValue
			)
		if $EL_light01 != undefined then
			(
			for LightsIndex in 1 to VertexCount by LightsStepValue do
 				(
				LightsNumber[LightsIndex].baseobject.falloff = LightsFalloffValue
				if (LightsNumber[LightsIndex].baseobject.falloff - 2) <= LightsHotspotValue then
					(
					LightsNumber[LightsIndex].baseobject.hotspot = LightsHotspotValue
					)
				)
			)
		)
	On LightsOvershoot changed val do
		(
		LightsOvershootChecked = val
		LightsHotspot.enabled = not LightsOvershootChecked
		if $EL_light01 != undefined then
			(
			for LightsIndex in 1 to VertexCount by LightsStepValue do
				(
				LightsNumber[LightsIndex].baseobject.overShoot = LightsOvershootChecked
				)
			)
		)
	)

--Dome Rollout

Rollout GeosphereCreation "Dome Settings"
	(
	Group "Dome Parameters"
	(
	Spinner GeosphereRadius "Radius:" range:[0,999999999,1000] scale:10 controller:GeosphereRadiusController align:#left offset:[9,0] width:107 across:2
	Spinner GeosphereSegments "Segments:" range:[1,10,2] type:#integer align:#right width:51 offset:[-1,0]
	Checkbox GeosphereHemisphere "Hemisphere" checked:on offset:[1,0]
	)
	On GeosphereRadius changed val do
		(
		GeosphereRadiusValue = val
		if $EL_dome!=undefined then
			(
			$EL_dome.radius = GeosphereRadiusValue
			VertexCount = getnumverts $EL_dome
			if GeosphereHemisphereChecked then VertexCount += -1
			for LightsIndex in 1 to VertexCount by LightsStepValue do
				(
 				VertexPosition = getvert $EL_dome LightsIndex
				LightsNumber[LightsIndex].pos = VertexPosition
				)
			GeosphereRadiusController.value = $EL_dome.radius
			)
		)
	On GeosphereSegments changed val do
		(
		GeosphereSegmentsValue = val
		FnTotalNumberOfLights()
		LightsCreation.LabelTotal.text = "Total: " + ((LightsCount as integer) as string) + " Lights (" + ((LightsMemory as integer) as string) + " Mb)"
		if $EL_dome != undefined then
			(
			$EL_dome.segs = GeosphereSegmentsValue
			VertexCount = getnumverts $EL_dome
			delete $EL_light*
			if GeosphereHemisphereChecked then VertexCount += -1
			LightsNumber = #()
			FnTotalNumberOfLights()
			disableSceneRedraw()
			for LightsIndex in 1 to VertexCount by LightsStepValue do
				(
				GeospherePosition = $EL_dome.pos
				VertexPosition = getvert $EL_dome LightsIndex
				LightsNumber[LightsIndex] = TargetSpot hotspot:LightsHotspotValue falloff:LightsFalloffValue overShoot:LightsOvershootChecked decayRadius:LightsStepValue attenDecay:1 raytracedShadows:off pos:VertexPosition enabled:LightsStatusChecked rgb:LightsColorRGB multiplier:(LightsMultiplierValue/(LightsCount as Integer)) castShadows:LightsShadowChecked shadowColor:(LightsShadowColorColor/(LightsCount as Integer)) shadowMultiplier:LightsShadowMultiplierValue mapbias:LightsMapBiasValue mapsize:LightsMapSizeValue samplerange:LightsSampleRangeValue parent:$EL_dome name:(uniquename "EL_light") target:(Targetobject name:(uniquename "EL_target") parent:$EL_dome transform:(matrix3 [1,0,0] [0,1,0] [0,0,1] GeospherePosition))
				)
				enableSceneRedraw()
			if EL_Map != undefined then
				(
				sceneMaterials["EL_dome_material"] = Standardmaterial()
				$EL_dome.material = sceneMaterials["EL_dome_material"]
				sceneMaterials["EL_dome_material"].Diffuse = LightsColorRGB
				sceneMaterials["EL_dome_material"].diffuseMap = Bitmaptexture filename:EL_Map.filename
				VertexCount = getnumverts $EL_dome
				if GeosphereHemisphereChecked then VertexCount += -1
				FnTotalNumberOfLights()
				for LightsIndex in 1 to VertexCount by LightsStepValue do
					(
					UVVert = getTVert $EL_dome LightsIndex
					EL_Map_X = (UVVert.x * EL_Map.width)
					if GeosphereHemisphereChecked then
						(
						EL_Map_Y = abs((2 * (1.0 - UVVert.y) * EL_Map.height) - 0.1)
						)
						else EL_Map_Y = abs(((1.0 - UVVert.y) * EL_Map.height) - 0.1)
					EL_Map_Pixel = getPixels EL_Map [EL_Map_X as integer,EL_Map_Y as integer] 1
					LightsNumber[LightsIndex].rgb = EL_Map_Pixel[1]
					)
				)
			)
		)
	On GeosphereHemisphere changed val do
		(
		GeosphereHemisphereChecked = val
		FnTotalNumberOfLights()
		LightsCreation.LabelTotal.text = "Total: " + ((LightsCount as integer) as string) + " Lights (" + ((LightsMemory as integer) as string) + " Mb)"
		if $EL_dome != undefined then
			(
			$EL_dome.hemisphere = GeosphereHemisphereChecked
			VertexCount = getnumverts $EL_dome
			delete $EL_light*
			if GeosphereHemisphereChecked then VertexCount += -1
			LightsNumber = #()
			FnTotalNumberOfLights()
			disableSceneRedraw()
			for LightsIndex in 1 to VertexCount by LightsStepValue do
				(
				GeospherePosition = $EL_dome.pos
				VertexPosition = getvert $EL_dome LightsIndex
				LightsNumber[LightsIndex] = TargetSpot hotspot:LightsHotspotValue falloff:LightsFalloffValue overShoot:LightsOvershootChecked decayRadius:LightsStepValue attenDecay:1 raytracedShadows:off pos:VertexPosition enabled:LightsStatusChecked rgb:LightsColorRGB multiplier:(LightsMultiplierValue/(LightsCount as Integer)) castShadows:LightsShadowChecked shadowColor:(LightsShadowColorColor/(LightsCount as Integer)) shadowMultiplier:LightsShadowMultiplierValue mapbias:LightsMapBiasValue mapsize:LightsMapSizeValue samplerange:LightsSampleRangeValue parent:$EL_dome name:(uniquename "EL_light") target:(Targetobject name:(uniquename "EL_target") parent:$EL_dome transform:(matrix3 [1,0,0] [0,1,0] [0,0,1] GeospherePosition))
				)
				enableSceneRedraw()
			if EL_Map != undefined then
				(
				sceneMaterials["EL_dome_material"] = Standardmaterial()
				$EL_dome.material = sceneMaterials["EL_dome_material"]
				sceneMaterials["EL_dome_material"].Diffuse = LightsColorRGB
				sceneMaterials["EL_dome_material"].diffuseMap = Bitmaptexture filename:EL_Map.filename
				VertexCount = getnumverts $EL_dome
				if GeosphereHemisphereChecked then VertexCount += -1
				FnTotalNumberOfLights()
				for LightsIndex in 1 to VertexCount by LightsStepValue do
					(
					UVVert = getTVert $EL_dome LightsIndex
					EL_Map_X = (UVVert.x * EL_Map.width)
					if GeosphereHemisphereChecked then
						(
						EL_Map_Y = abs((2 * (1.0 - UVVert.y) * EL_Map.height) - 0.1)
						)
						else EL_Map_Y = abs(((1.0 - UVVert.y) * EL_Map.height) - 0.1)
					EL_Map_Pixel = getPixels EL_Map [EL_Map_X as integer,EL_Map_Y as integer] 1
					LightsNumber[LightsIndex].rgb = EL_Map_Pixel[1]
					)
				)
			)
		)
	)

--Bitmap Rollout
	
Rollout BitmapUsage "Bitmap Settings"
	(
	Button BitmapSelect "Select Bitmap" width:194 align:#center
	Button BitmapRemove "Remove Bitmap" width:194 align:#center enabled:off
	On BitmapSelect pressed do
		(
		EL_Map = selectBitmap caption:"Select Bitmap"
		if EL_Map != undefined then
			(
			BitmapRemove.enabled = true
			LightsCreation.LightsColor.enabled = false
			BitmapSelect.text = EL_Map.filename
			EL_Map = openBitmap EL_Map.filename
			EL_Map_Width = EL_Map.width
			EL_Map_Height = EL_Map.height
			if $EL_dome != undefined then
				(
				sceneMaterials["EL_dome_material"] = Standardmaterial()
				$EL_dome.material = sceneMaterials["EL_dome_material"]
				sceneMaterials["EL_dome_material"].Diffuse = LightsColorRGB
				sceneMaterials["EL_dome_material"].diffuseMap = Bitmaptexture filename:EL_Map.filename
				VertexCount = getnumverts $EL_dome
				if GeosphereHemisphereChecked then VertexCount += -1
				FnTotalNumberOfLights()
				for LightsIndex in 1 to VertexCount by LightsStepValue do
					(
					UVVert = getTVert $EL_dome LightsIndex
					EL_Map_X = (UVVert.x * EL_Map.width)
					if GeosphereHemisphereChecked then
						(
						EL_Map_Y = abs((2 * (1.0 - UVVert.y) * EL_Map.height) - 0.1)
						)
						else EL_Map_Y = abs(((1.0 - UVVert.y) * EL_Map.height) - 0.1)
					EL_Map_Pixel = getPixels EL_Map [EL_Map_X as integer,EL_Map_Y as integer] 1
					LightsNumber[LightsIndex].rgb = EL_Map_Pixel[1]
					)
				)
			)
		else if sceneMaterials["EL_dome_material"] != undefined then
			(
			EL_Map = sceneMaterials["EL_dome_material"].diffuseMap
			)
		)
	On BitmapRemove pressed do
		(
		BitmapRemove.enabled = false
		LightsCreation.LightsColor.enabled = true
		EL_Map = undefined
		BitmapSelect.text = "Select Bitmap"
		if $EL_light01 != undefined then
			(
			$EL_dome.material = undefined
			if sceneMaterials["EL_dome_material"].diffuseMap != undefined then sceneMaterials["EL_dome_material"].diffuseMap = undefined
			for LightsIndex in 1 to VertexCount by LightsStepValue do
				(
				LightsNumber[LightsIndex].baseobject.rgb = LightsColorRGB
				)
			)
		)
	)
	
Rollout HideUnhide "Hide/Unhide Environment Light"
	(
	Button HideAll "Hide E-Light" align:#left width:90 offset:[1,0] across:2
	Button UnhideAll "Unhide E-Light" align:#right width:90 offset:[-1,0]
	On HideAll pressed do
		(
		hide $EL_dome*
		hide $EL_light*
		)
	On UnhideAll pressed do
		(
		unhide $EL_dome*
		unhide $EL_light*
		)	
	)
	
Rollout AboutEL "About E-Light"
	(
	Label LabelVersion "Version: 1.0" align:#center
	Label LabelRelease "Release: 15 January 2003"
	Label LabelAuthor "Author: Ronnie Olsthoorn" align:#center
	Button Contact "skyraider3d@hotmail.com" align:#center
	Button Website "http://www.skyraider3d.com" align:#center	
	On Contact pressed do
		(
		assetBrowser.open()
		assetBrowser.gotoURL "http://home.wanadoo.nl/r.j.o/skyraider/e-mail_index.htm"
		)
	On Website pressed do
		(
		assetBrowser.open()
		assetBrowser.gotoURL "http://home.wanadoo.nl/r.j.o/skyraider/index.htm"
		)
	)

--E.L. Floater Creation

if EL_Floater != undefined do
				(
				closerolloutfloater EL_Floater
				)
EL_Floater = NewRolloutFloater "E-Light" 250 436
AddRollout GeosphereCreation EL_Floater
AddRollout LightsCreation EL_Floater
AddRollout BitmapUsage EL_Floater rolledUp:on
AddRollout ELCreate EL_Floater rolledUp:on
AddRollout HideUnhide EL_Floater rolledUp:on
AddRollout AboutEL EL_Floater rolledUp:on

--Initialise Controllers

LightsMultiplierController.value = 1.0
LightsShadowMultiplierController.value = 1.0
GeosphereRadiusController.value = 1000.0

--Import current scene automatically

if ($EL_dome != undefined) and ($EL_light01 != undefined) then
	(
	GeosphereHemisphereChecked = $EL_dome.hemisphere
	GeosphereCreation.GeosphereHemisphere.checked = GeosphereHemisphereChecked
	GeospherePosition = $EL_dome.pos
	GeosphereRadiusValue = $EL_dome.radius
	GeosphereCreation.GeosphereRadius.value = GeosphereRadiusValue
	GeosphereSegmentsValue = $EL_dome.segs
	GeosphereCreation.GeosphereSegments.value = GeosphereSegmentsValue
	LightsCount = $EL_Light*.count
	LightsFalloffValue = $EL_Light01.baseobject.falloff
	LightsCreation.LightsFalloff.value = LightsFalloffValue
	LightsMapBiasValue = $EL_Light01.baseobject.mapbias
	LightsCreation.LightsMapBias.value = LightsMapBiasValue
	LightsHotspotValue = $EL_Light01.baseobject.hotspot
	LightsCreation.LightsHotspot.value = LightsHotspotValue
	LightsSampleRangeValue = $EL_Light01.baseobject.samplerange
	LightsCreation.LightsSampleRange.value = LightsSampleRangeValue
	LightsMapSizeValue = $EL_Light01.baseobject.mapsize
	LightsCreation.LightsMapSize.value = LightsMapSizeValue
	LightsMultiplierValue = ($EL_Light01.baseobject.multiplier * LightsCount)
	LightsCreation.LightsMultiplier.value = LightsMultiplierValue
	LightsOvershootChecked = $EL_Light01.baseobject.overShoot
	LightsCreation.LightsHotspot.enabled = not LightsOvershootChecked
	LightsCreation.LightsOvershoot.checked = LightsOvershootChecked
	LightsShadowColorColor = $EL_Light01.baseobject.shadowColor
	LightsCreation.LightsShadowColor.color = (LightsShadowColorColor * LightsCount)
	LightsShadowMultiplierValue = $EL_Light01.baseobject.shadowMultiplier
	LightsCreation.LightsShadowMultiplier.value = LightsShadowMultiplierValue
	LightsShadowChecked = $EL_Light01.baseobject.castShadows
	LightsCreation.LightsShadow.checked = LightsShadowChecked
	LightsStatusChecked = $EL_Light01.baseobject.enabled
	LightsCreation.LightsStatus.checked = LightsStatusChecked
	LightsColorRGB = $EL_Light01.baseobject.rgb
	LightsCreation.LightsColor.color = LightsColorRGB
	LightsStepValue = ($EL_Light01.baseobject.decayRadius as integer)
	LightsCreation.LightsStep.value = LightsStepValue
	VertexCount = getnumverts $EL_dome
	if GeosphereHemisphereChecked then VertexCount += -1
	FnTotalNumberOfLights()
	TempNumber = #()
	TempNumber = $EL_Light*
	TempIndex = 1
	LightsNumber = #()
	for LightsIndex in 1 to VertexCount by LightsStepValue do
		(
		LightsNumber[LightsIndex] = TempNumber[TempIndex]
		TempIndex += 1
		)
	LightsCreation.LabelTotal.text = "Total: " + ((LightsCount as integer) as string) + " Lights (" + ((LightsMemory as integer) as string) + " Mb)"
	if (sceneMaterials["EL_dome_material"] != undefined) then
		(
		EL_Map = sceneMaterials["EL_dome_material"].diffuseMap
		EL_Map = sceneMaterials["EL_dome_material"].diffuseMap
		if EL_Map != undefined then
			(
			EL_Map = openBitmap EL_Map.filename
			EL_Map_Height = EL_Map.height
			EL_Map_Width = EL_Map.width
			BitmapUsage.BitmapSelect.text = EL_Map.filename
			BitmapUsage.BitmapRemove.enabled = true
			LightsCreation.LightsColor.enabled = false
			)
		LightsColorRGB = sceneMaterials["EL_dome_material"].Diffuse
		LightsCreation.LightsColor.color = LightsColorRGB
		)
	)
