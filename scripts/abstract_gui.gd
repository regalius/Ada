extends Control

var references={
	"rootNode":""
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
	pass

func initConnections():
	pass

func initCurrents():
	pass 