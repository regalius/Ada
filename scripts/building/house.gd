extends "../abstract_building.gd"


func initReferences():
	references={
		"houseValueLbl":""
	}
	references["houseValueLbl"] = self.get_node("housevalue_lbl")

func initObjectAttribute(attribute):
	objectAttribute = {
		"houseValue" : 0
	}
	self.setHouseValue(attribute["houseValue"])
	pass
	
func setHouseValue(value):
	objectAttribute["houseValue"] = value
	print(str(references["houseValueLbl"]))
	references["houseValueLbl"].set_text(str(objectAttribute["houseValue"]))

func receiveItem(received):
	if received:
		references["houseValueLbl"].set_text("YAY!")
	