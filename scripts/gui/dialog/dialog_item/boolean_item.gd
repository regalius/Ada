
extends "../../../abstract_dialogitem.gd"

var alphaDict = [-1, "A","B","C","D","E","F","G","H","I","J","K","L","M","N","O","P","Q","R","S","T","U","V","W","X","Y","Z"]

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
	pass
	
func initConnections():
	references["btn"].connect("pressed",self,"changeValue")

func changeValue():
	if currents["value"]:
		self.setValue(false)
	else:
		self.setValue(true)
	
func setValue(value):
	.setValue(value)
	references["btn"].set_text(TranslationServer.tr(str(value).to_upper()))
