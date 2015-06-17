
extends "../abstract_gui.gd"

# member variables here, example:
# var a=2
# var b="textvar"


func _ready():
	# Initialization here
	pass

func initCurrents():
	currents["brushType"] = -1
	currents["brushMode"] = "paint"

func initReferences():
	.initReferences()
	references["editorController"] = references["rootNode"].references["editorController"]
	references["filenameEdit"] = self.get_node("top_center/center/savebox/container/lineedit_container/filename_edit")
	references["loadBtn"] = self.get_node("top_center/center/savebox/container/btn_container/container/load_btn")
	references["saveBtn"] = self.get_node("top_center/center/savebox/container/btn_container/container/save_btn")
	references["playBtn"] = self.get_node("top_center/center/savebox/container/btn_container/container/play_btn")
	references["toolBox"] = self.get_node("right/center/toolbox_root")
	references["levelDataEditBtn"] = self.get_node("left/center/propertybox/item_container/container/leveldataedit_btn")
	references["toggleObjectBtn"] =  self.get_node("left/center/propertybox/item_container/container/toggleobject_btn")
	references["undoBtn"] =  self.get_node("left/center/propertybox/item_container/container/undo_btn")
	 
func setActiveBrush(brushBtn):
	currents["brushType"] = brushBtn.getBrushType()
	currents["brushMode"] = brushBtn.getBrushMode()
	references["toolBox"].resetButton()
	brushBtn.set_disabled(true)
	references["editorController"].setActiveBrush(currents["brushMode"],currents["brushType"])

func initConnections():
	references["levelDataEditBtn"].connect("pressed",references["editorController"],"modifyLevelData")
	references["toggleObjectBtn"].connect("pressed",references["editorController"],"toggleObject")
	references["undoBtn"].connect("pressed",references["editorController"],"undo")
	references["loadBtn"].connect("pressed",self,"loadMap")
	references["saveBtn"].connect("pressed",self,"saveMap")
	references["playBtn"].connect("pressed",self,"playMap")
	pass

func loadMap():
	references["editorController"].loadMap(false,references["filenameEdit"].get_text())
	pass

func saveMap():
	references["editorController"].saveMap(false,references["filenameEdit"].get_text())
	pass

func playMap():
#	self.saveMap()
	references["editorController"].playMap(false, references["filenameEdit"].get_text())
	pass

func getActiveBrush():
	return currents["brushType"]