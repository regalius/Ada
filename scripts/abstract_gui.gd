extends Control

var references={
	"rootNode":"",
	"guiRoot":""
}
var prefabs ={}
var currents = {}

func _ready():
	pass
	
func init():
	self.initReferences()
	self.initConnections()
	self.reset()
	pass

func initReferences():
	references["rootNode"] = self.get_node("/root").get_child(self.get_node("/root").get_child_count()-1)
	references["guiRoot"] = references["rootNode"].get_node("gui_layer/canvas_item/gui_root")
	pass

func initConnections():
	pass

func initCurrents():
	pass 
	
func reset():
	pass