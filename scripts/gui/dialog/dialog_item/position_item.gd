
extends "../../../abstract_dialogitem.gd"

func _ready():
	pass


func init(nameparam, value):
	.init()
	self.setValue(nameparam, value)
	self.setName(nameparam)
	pass

func initReferences():
	references["x"] = self.get_node("x")
	references["y"] = self.get_node("y")
	references["direction"] = self.get_node("direction")

func setValue(nameparam, value):
	references["x"].init(nameparam +" x", value.x)
	references["y"].init(nameparam +" y", value.y)
	references["direction"].init(nameparam +" direction", value.direction)
	
func getValue():
	currents["value"] = {"x": references["x"].getValue(), "y": references["y"].getValue(), "z":0, "direction": references["direction"].getValue()}
	return currents["value"]
