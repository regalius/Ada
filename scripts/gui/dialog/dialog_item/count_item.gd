
extends "../../../abstract_dialogitem.gd"

export var MaxValue = 0

func _ready():
	# Initialization here
	pass

func init(nameparam, value):
	.init()
	self.setMaxValue("")
	self.setName(nameparam)
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

func setValue(val):
	if val <= currents["minValue"]:
		val = currents["minValue"]
	elif val >= currents["maxValue"]:
		val = currents["maxValue"]

	.setValue(val)
	references["valueLbl"].set_text(str(currents["value"]))
	
	
func setMaxValue(maxval):
	if maxval == "":
		currents["maxValue"] = MaxValue
		currents["minValue"] = -1
	else:
		currents["maxValue"] = maxval
		currents["minValue"] = -1
			
func getValue():
	return currents["value"]

func getMaxValue():
	return currents["maxValue"]
