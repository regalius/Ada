
extends "../abstract_gui.gd"

# member variables here, example:
# var a=2
# var b="textvar"
	
func initReferences():
	.initReferences()
	references["playBtn"] = self.get_node("center/menu_button/play_btn")
	references["optionBtn"] = self.get_node("center/menu_button/option_btn")
	references["backBtn"] = self.get_node("back_button/back_btn")

func initConnections():
	references["playBtn"].connect("pressed", self.get_parent(), "buttonPressed",["setCurrentGUI",["levelMenu"]])
	references["optionBtn"].connect("pressed", self.get_parent(), "buttonPressed",["setCurrentGUI",["optionMenu"]])
	references["backBtn"].connect("pressed", self.get_parent(), "buttonPressed",["showDialog",["true","quit"]])
	references["backBtn"].connect("pressed", self.get_parent(), "buttonPressed",["goToEditorMode",""])