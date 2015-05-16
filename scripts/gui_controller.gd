
extends Control

# member variables here, example:
# var a=2
# var b="textvar"

var references = {
	"mainMenu" : "",
	"levelMenu" : "",
	"optionMenu" : "",
	"gameUI" : "",
	"rootNode":""
}

func _ready():
	# Initialization here
	initReferences()
	pass
	
func init():
	self.setCurrentGUI("mainMenu")
	for gui in self.get_children():
		gui.init()
		
func initReferences():
	references["mainMenu"] = self.get_node("mainmenu_root")
	references["levelMenu"] = self.get_node("levelmenu_root")
	references["optionMenu"] = self.get_node("optionmenu_root")
	references["gameUI"] = self.get_node("gameui_root")
	references["rootNode"] = self.get_node("/root").get_child(self.get_node("/root").get_child_count()-1)
	pass

func buttonPressed(action, parameter):
	references["rootNode"].references["soundController"].playSFX("click",true)
	if(action == "setCurrentGUI"):
		self.setCurrentGUI(parameter[0])
	elif(action == "quitGame"):
		self.quitGame()
	elif(action == "setLevelSection"):
		references["levelMenu"].setLevelSection(parameter[0])
	elif(action == "changeSettings"):
		references["optionMenu"].changeSettings(parameter[0],parameter[1],parameter[2])
	elif(action == "loadMap"):
		references["rootNode"].startGame(parameter[0])
	pass


func setCurrentGUI(gui):
	for scene in self.get_children():
		scene.hide()
	references[gui].show()
	references["rootNode"].setCurrents("GUI", gui)
	pass
	
func quitGame():
	OS.get_main_loop().quit()
	pass
	
