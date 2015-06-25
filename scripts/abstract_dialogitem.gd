extends Control

export var varName = ""

var references={
	"rootNode":"",
	"guiRoot":""
}
var currents = {}

func _ready():
	pass
	
func init():
	self.initReferences()
	pass

func initReferences():
	references["rootNode"] = self.get_node("/root").get_child(self.get_node("/root").get_child_count()-1)
	references["guiRoot"] = references["rootNode"].references["guiRoot"]
	pass

func initConnections():
	pass

	
func setValue(val):
	currents["value"]=val

func getValue():
	return currents["value"]

func setName(val):
	if val == "":
		val == varName

	if references.has("nameLbl"):
		references["nameLbl"].set_text(TranslationServer.tr(val))

func getName():
	return varName
