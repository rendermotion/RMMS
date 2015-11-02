fn RMcreateDirectories FolderPath =(
	makeDir (FolderPath + "\\1.-Documents")
	makeDir (FolderPath + "\\2.-Art&Reference")
	makeDir (FolderPath + "\\3.-Design")
	makeDir (FolderPath + "\\4.-StoryBoard")
	makeDir (FolderPath + "\\5.-Animatic")
	makeDir (FolderPath + "\\6.-Assets")
	makeDir (FolderPath + "\\7.-Characters")
	makeDir (FolderPath + "\\8.-Stage")
	makeDir (FolderPath + "\\9.-Animation")
	makeDir (FolderPath + "\\10.-Efectos")
	makeDir (FolderPath + "\\11.-Renderoutput")
	makeDir (FolderPath + "\\12.-Compositing")
	makeDir (FolderPath + "\\13.-Audio")
	makeDir (FolderPath + "\\14.-FinalComposite")
	makeDir (FolderPath + "\\15.-Scripts")
	)
rollout ProjectFolderRollout "Carpetas de Proyecto" width:162 height:300
(
	button FolderBtn "Choose Folder" pos:[24,12] width:112 height:33

	
	on FolderBtn pressed do (
		a=getSavePath()
		if a != undefined do
			RMcreateDirectories a
	)
	
		
)
ProjectFloater = newRolloutFloater "Administración de Proyecto" 380 320
addRollout ProjectFolderRollout ProjectFloater
