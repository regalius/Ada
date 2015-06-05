
extends Control

# member variables here, example:
# var a=2
# var b="textvar"

var references = {
	"mainMenu" : "",
	"levelMenu" : "",
	"optionMenu" : "",
	"resultMenu":"",
	"dialogUI":"",
	"gameUI" : "",
	"editorUI":"",
	"rootNode":""
}

func _ready():
	# Initialization here
	self.initReferences()
	pass
	
func init():
	self.setCurrentGUI("mainMenu")
	for gui in self.get_children():
		gui.init()
		
func initReferences():
	references["mainMenu"] = self.get_node("mainmenu_root")
	references["levelMenu"] = self.get_node("levelmenu_root")
	references["optionMenu"] = self.get_node("optionmenu_root")
	references["resultMenu"] = self.get_node("resultmenu_root")
	references["gameUI"] = self.get_node("gameui_root")
	references["editorUI"] = self.get_node("editorui_root")
	references["dialogUI"] = self.get_node("dialogui_root")
	references["rootNode"] = self.get_node("/root").get_child(self.get_node("/root").get_child_count()-1)
	pass

#func buttonPressed(action, parameter):
#	references["rootNode"].references["soundController"].playSFX("click",true)
#	if action == "setCurrentGUI":
#		self.setCurrentGUI(parameter[0])
#	elif action == "quitGame":
#		references["rootNode"].quitGame()
#	elif action == "setLevelSection":
#		references["levelMenu"].setLevelSection(parameter[0])
#	elif action == "changeSettings":
#		references["optionMenu"].changeSettings(parameter[0],parameter[1],parameter[2])
#	elif action == "startLevel":
#		references["rootNode"].startLevel(parameter[0])
#	elif action == "startNextLevel":
#		references["rootNode"].startLevel(references["rootNode"].getNextLevel())
#	elif action == "quitLevel":
#		references["rootNode"].quitLevel()
#	elif action == "showDialog":
#		self.showDialog(parameter[0],parameter[1])
#	elif action == "retryLevel":
#		references["rootNode"].references["gameController"].retryLevel()
#	elif action == "playSolverAlgorithm":
#		references["rootNode"].references["gameController"].playSolverAlgorithm(parameter[0])
#	elif action == "resetMap":
#		references["rootNode"].references["gameController"].resetMap()
#	elif action == "startEditor":
#		references["rootNode"].startEditor()
#	elif action == "quitEditor":
#		references["rootNode"].quitEditor()
#	elif action == "setActiveBrush":
#		references["editorUI"].setActiveBrush(parameter[0])
#	pass


func setCurrentGUI(gui):
	for scene in self.get_children():
		scene.hide()
	references[gui].show()
	references["rootNode"].currents["GUI"] = gui
	pass

func getGUI(name):
	return references[name]

func pauseGame(state):
	references["rootNode"].get_tree().set_pause(state)

func showDialog(state, sender, type, parameter):
	references["rootNode"].get_tree().set_pause(state)
	if state:
		references["dialogUI"].setDialogType(sender, type, parameter)
		references["dialogUI"].show()
	else:
		references["dialogUI"].getCurrentDialog().exitDialog()
		references["dialogUI"].hide()
	