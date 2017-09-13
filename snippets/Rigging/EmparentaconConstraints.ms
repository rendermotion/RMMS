fn ParentWithConstraints Child Parent=(
			a=Position_Constraint ()
			ai=a.constraints
			Child.position.controller=a
			ai.appendTarget Parent 50.0
			a=Orientation_Constraint ()
			ai=a.constraints
			Child.rotation.controller=a
			ai.appendTarget Parent 50.0
			)
ParentWithConstraints $[1] $[2]