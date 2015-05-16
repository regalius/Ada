
extends "../abstract_gui.gd"

# member variables here, example:
# var a=2
# var b="textvar"
	
func initReferences():
	references = {
		"playBtn":"",
		"optionBtn":"",
		"backBtn":"",
		"rootNode":"",
	}
	references["playBtn"] = self.get_node("center/menu_button/play_btn")
	references["optionBtn"] = self.get_node("center/menu_button/option_btn")
	references["backBtn"] = self.get_node("back_button/back_btn")
	references["rootNode"] = self.get_node("/root").get_child(self.get_node("/root").get_child_count()-1)

func initConnections():
	references["playBtn"].connect("pressed", self.get_parent(), "buttonPressed",["setCurrentGUI",["levelMenu"]])
	references["optionBtn"].connect("pressed", self.get_parent(), "buttonPressed",["setCurrentGUI",["optionMenu"]])
	references["backBtn"].connect("pressed", self.get_parent(), "buttonPressed",["quitGame",""])