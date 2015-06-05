
extends "../../../abstract_dialogitem.gd"

func _ready():
	# Initialization here
	pass

func init(nameparam, value):
	.init()
	self.setName(nameparam)
	self.setValue(value)
	self.initConnections()
	
func initReferences():
	references["nameLbl"] = self.get_node("container/item_lbl")
	references["textEdit"] = self.get_node("container/text_edit")

func initConnections():
	references["textEdit"].connect("text_changed", self, "updateValue")
	pass

func setValue(value):
	.setValue(value)
	references["textEdit"].set_text(value)

func updateValue(text):
	currents["value"] = text
	print(currents["value"])