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
	pass

func initReferences():
	references["rootNode"] = self.get_node("/root").get_child(self.get_node("/root").get_child_count()-1)
	references["guiRoot"] = references["rootNode"].references["guiRoot"]
	pass

func initConnections():
	pass

func initCurrents():
	pass 