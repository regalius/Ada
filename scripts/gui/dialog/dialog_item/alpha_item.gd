
extends "../../../abstract_dialogitem.gd"

var alphaDict = [-1, "A","B","C","D","E","F","G","H","I","J","K","L","M","N","O","P","Q","R","S","T","U","V","W","X","Y","Z"]

func _ready():
	# Initialization here
	pass

func init(nameparam, value):
	.init()
	self.setName(nameparam)
	self.setMaxValue()
	self.setValue(value)
	self.initConnections()
	pass

func initReferences():
	references["plusBtn"] = self.get_node("container/btn_plus")
	references["minBtn"] = self.get_node("container/btn_min")
	references["nameLbl"] = self.get_node("container/item_lbl")
	references["valueLbl"] = self.get_node("container/value_lbl")
	pass

func initConnections():
	references["plusBtn"].connect("pressed",self, "changeValue", ["plus"])
	references["minBtn"].connect("pressed",self, "changeValue", ["min"])

func changeValue(command):
	var val = currents["value"]
	
	if command == "plus"  :
		val = currents["value"]+1
		if val > currents["maxValue"]:
			val = currents["minValue"]

	elif command == "min":
		val = currents["value"]-1
		if val < currents["minValue"]:
			val = currents["maxValue"]
	
	self.setValue(val)

func translateToAlpha(val):
	return alphaDict[val]

func translateToNumeric(val):
	return alphaDict.find(val)

func setValue(val):
	var value = self.translateToNumeric(val)
	if val <= currents["minValue"]:
		value = currents["minValue"]
	elif val >= currents["maxValue"]:
		value = currents["maxValue"]

	.setValue(value)
	references["valueLbl"].set_text(self.translateToAlpha(currents["value"]))

func setMaxValue(maxval):
	currents["maxValue"] = 26
	currents["minValue"] = 1
		
func getValue():
	return self.translateToAlpha(currents["value"])

func getMaxValue():
	return currents["maxValue"]
