
extends "../../../abstract_dialogitem.gd"

func _ready():
	# Initialization here
	pass


func init(nameparam, value):
	.init()
	self.setName(nameparam)
	self.setValue(value)
	self.initConnections()
	pass

func initReferences():
	references["nameLbl"] = self.get_node("container/item_lbl")
	references["btn"] = self.get_node("container/btn")

func initConnections():
	references["btn"].connect("pressed",self,"changeValue")

func changeValue():
	if currents["value"] == "front":
		self.setValue("right")
	elif currents["value"] == "right":
		self.setValue("back")
	elif currents["value"] == "back":
		self.setValue("left")
	elif currents["value"] == "left":
		self.setValue("front")

func setValue(value):
	if value == "front" or value == "right" or value == "back" or value == "left":
		.setValue(value)
		references["btn"].set_text(TranslationServer.tr(currents["value"]))