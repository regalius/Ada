
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
var currents = {
	"GUI":"",
	"CONVERSATION_ON":false,
	"DIALOG_ON":false
}
func _ready():
	# Initialization here
	pass
	
func init():
	self.initReferences()
	for gui in references["guiContainer"].get_children():
		gui.init()
	self.setCurrentGUI("mainMenu")
	self.initConnections()
		
func initReferences():
	references["guiContainer"] = self.get_node("gui_container")
	references["mainMenu"] = references["guiContainer"].get_node("mainmenu_root")
	references["levelMenu"] = references["guiContainer"].get_node("levelmenu_root")
	references["optionMenu"] = references["guiContainer"].get_node("optionmenu_root")
	references["resultMenu"] = references["guiContainer"].get_node("resultmenu_root")
	references["gameUI"] = references["guiContainer"].get_node("gameui_root")
	references["editorUI"] = references["guiContainer"].get_node("editorui_root")
	references["conversationUI"] = references["guiContainer"].get_node("conversationui_root")
	references["dialogUI"] = references["guiContainer"].get_node("dialogui_root")
	references["tutorialUI"] = references["guiContainer"].get_node("tutorial_root")
	references["rootNode"] = self.get_node("/root").get_child(self.get_node("/root").get_child_count()-1)
	references["backBtn"] = self.get_node("top_left/back_btn")
	pass

func initConnections():
	references["backBtn"].connect("pressed",self, "backAction")

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
	for scene in references["guiContainer"].get_children():
		scene.hide()
	references[gui].show()
	currents["GUI"] = gui
	pass

func getGUI(name):
	return references[name]

func pauseGame(state):
#	if not state and currents["CONVERSATION_ON"]:
#		references["rootNode"].get_tree().set_pause(true)
#	else:
	references["rootNode"].get_tree().set_pause(state)


func showDialog(state, sender, type, parameter):
	currents["DIALOG_ON"] = state
	self.pauseGame(state)
	if state:
		references["dialogUI"].setDialogType(sender, type, parameter)
		references["dialogUI"].show()
	else:
		references["dialogUI"].getCurrentDialog().exitDialog()
		references["dialogUI"].hide()
	
func showConversation(state, sender, conversationDict):
	currents["CONVERSATION_ON"] = state
#	self.pauseGame(state)
	if state:
		references["conversationUI"].show()
		references["conversationUI"].startConversation(sender, conversationDict)
	else:
		references["conversationUI"].hide()
		
func showTutorial(state,sender, tutorialArray):
	if state:
		references["tutorialUI"].show()
		references["tutorialUI"].startTutorial(sender,tutorialArray)
	else:
		references["tutorialUI"].hide()
		
func backAction():
	if currents["GUI"] == "mainMenu":
		self.showDialog(true,self, "yesno",["quit"])
	elif currents["GUI"] == "levelMenu":
		self.setCurrentGUI("mainMenu")
	elif currents["GUI"] == "gameUI":
		if references["gameUI"].isPreviewMode():
			self.showDialog(true,self,"yesno",["previewMode"])
		else:
			self.showDialog(true,self,"yesno",["levelMenu"])
	elif currents["GUI"] == "editorUI":
		if references["rootNode"].getCurrentController().isSaved():
			references["rootNode"].quitEditor()
		else:
			self.showDialog(true,self,"yesno",["editorMode"])