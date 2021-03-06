extends "../abstract_object.gd"

func init(map, cellData):
	defaultAttribute = {
		"houseValue" : -1,
		"direction" : "front"
	}
	
	.init(map, cellData)
	self.setType("house")
	self.setHouseValue(currents["houseValue"])

func initReferences():
	.initReferences()
	references["houseValueLbl"] = self.get_node("housevalue_lbl")

func initCurrents():
	.initCurrents()
#	if objectAttribute.has("houseValue"):
	currents["houseValue"] = objectAttribute["houseValue"]
#	else:
#		currents["houseValue"] = -1
	currents["IS_DELIVERED"]= false
	currents["CAN_DELIVER"]= true

func interact(actor, nextPos):
	self.receiveItem(true, nextPos)
	
func updateObject():
	if not currents["IS_DELIVERED"] and currents["CAN_DELIVER"]== true:
		if not currents["houseValue"] == -1:
			if currents["houseValue"] >0:
				self.setHouseValue(currents["houseValue"]-1)
			else:
				self.receiveItem(false,"")

func resetObject():
	self.setHouseValue(objectAttribute["houseValue"])
	currents["IS_DELIVERED"] = false
	currents["CAN_DELIVER"] = true
	
func setHouseValue(value):
	currents["houseValue"] = value
	if currents["houseValue"] > -1:
		references["houseValueLbl"].show()
		references["houseValueLbl"].set_text(str(currents["houseValue"]))
	else:
		references["houseValueLbl"].hide()

func receiveItem(received, playerNextPos):
	if currents["CAN_DELIVER"]:
		if received:
#map			print("housepos: " + str(currents["position"]) + " | playerpos: "+ str(playerNextPos) + " " + str(self.isPlayerPositionValid(playerNextPos)))
			if self.isPlayerPositionValid(playerNextPos):
				references["houseValueLbl"].show()
				references["houseValueLbl"].set_text(TranslationServer.tr("HOUSE_RECEIVED"))
				currents["IS_DELIVERED"] = true
		else:
			references["houseValueLbl"].show()
			references["houseValueLbl"].set_text(TranslationServer.tr("HOUSE_FAILED"))
			currents["CAN_DELIVER"] = false

func isPlayerPositionValid(playerNextPos):
	if currents["position"].x == playerNextPos.x and currents["position"].y == playerNextPos.y and currents["position"].z == playerNextPos.z:
		if (currents["position"].direction == "front" and playerNextPos.direction == "back") or (currents["position"].direction == "back" and playerNextPos.direction == "front") or (currents["position"].direction == "left" and playerNextPos.direction == "right") or (currents["position"].direction == "right" and playerNextPos.direction == "left"):
			return true
		else:
			return false
	else:
		return false

func isDelivered():
	return currents["IS_DELIVERED"]