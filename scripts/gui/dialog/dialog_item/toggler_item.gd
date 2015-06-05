
extends "../../../abstract_dialogitem.gd"

# member variables here, example:
# var a=2
# var b="textvar"

func _ready():
	# Initialization here
	pass

func init(nameparam, val1, val2, value):
	.init()
	self.setName(nameparam)
	self.setInitialValue(val1,val2)
	self.setValue(value)
	self.initConnections()
	pass

func initReferences():
	.initReferences()
	references["nameLbl"] = self.get_node("container/name_lbl")
	references["btn1"] = self.get_node("container/btn_1")
	references["btn2"] = self.get_node("container/btn_2")

func initConnections():
	references["btn1"].connect("pressed", self, "setValue", [currents["val1"]])
	references["btn2"].connect("pressed", self, "setValue", [currents["val2"]])

func setValue(value):
	.setValue(value)
	references["btn1"].set_disabled(false)
	references["btn2"].set_disabled(false)

	if currents["val1"] == value:
		references["btn1"].set_disabled(true)
	elif currents["val2"] == value:
		references["btn2"].set_disabled(true)

func setInitialValue(val1,val2):
	currents["val1"] = val1
	currents["val2"] = val2
	references["btn1"].get_node("label").set_text(TranslationServer.tr(currents["val1"]))
	references["btn2"].get_node("label").set_text(TranslationServer.tr(currents["val2"]))
	pass