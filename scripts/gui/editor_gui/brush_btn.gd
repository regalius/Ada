
extends "../button.gd"

# member variables here, example:
# var a=2
# var b="textvar"
export var brushType = -1
export var brushMode = "paint"
func _ready():
	# Initialization here
#	self.init()
	pass

func init():
	self.initReferences()
	self.initConnections()
	
	
func initReferences():
	references["rootNode"] = self.get_node("/root").get_child(self.get_node("/root").get_child_count()-1)
	references["guiRoot"] = references["rootNode"].getGUIRoot()
	references["editorUI"] = references["guiRoot"].get_node("editorui_root")
	
func initConnections():
	self.connect("pressed", self, "setActiveBrush")
	pass

func setActiveBrush():
	references["editorUI"].setActiveBrush(brushMode, brushType)

func setbrushType(index):
	brushType = index

func getbrushType():
	return brushType