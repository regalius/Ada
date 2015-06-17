
extends "../abstract_gui.gd"

func initReferences():
	.initReferences()
	references["playBtn"] = self.get_node("center/menu_button/play_btn/play_btn")
	references["optionBtn"] = self.get_node("center/menu_button/option_btn/option_btn")
	references["editorBtn"] = self.get_node("center/menu_button/editor_btn/editor_btn")
	references["rootNode"] = self.get_node("/root").get_child(self.get_node("/root").get_child_count()-1)
	
func initConnections():
	references["playBtn"].connect("pressed", references["guiRoot"], "setCurrentGUI",["levelMenu"])
	references["optionBtn"].connect("pressed", references["guiRoot"], "showDialog",[true,self, "option",""])
	references["editorBtn"].connect("pressed", references["rootNode"], "startEditor")	