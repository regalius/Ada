
extends "../../abstract_dialog.gd"

# member variables here, example:
# var a=2
# var b="textvar"

func _ready():
	# Initialization here
#	self.init()
#	self.enterDialog("hoho",[{"x":0,"y":0,"z":0,"direction":"front"}, {
#									"candy":{
#										"1": 0,
#										"2": 0,
#										"3": 0
#									}
#								}])
	pass

func initReferences():
	.initReferences()
	references["playerPos"] = self.get_node("itemscroll_container/item_container/player_position")
	references["candy1"] = self.get_node("itemscroll_container/item_container/candy_1")
	references["candy2"] = self.get_node("itemscroll_container/item_container/candy_2")
	references["candy3"] = self.get_node("itemscroll_container/item_container/candy_3")
	references["maxFunction"] = self.get_node("itemscroll_container/item_container/max_func")
	references["saveBtn"] = self.get_node("confirm_btn/save_btn")
	references["cancelBtn"] = self.get_node("confirm_btn/cancel_btn")

func initConnections():
	references["cancelBtn"].connect("pressed", references["guiRoot"], "showDialog",[false,"", "levelDataEdit",""])
	references["saveBtn"].connect("pressed",self, "saveData")

func enterDialog(sender,parameter):
	.enterDialog(sender,parameter)
	self.setPlayerData(parameter[0])
	self.setLevelData(parameter[1])
	self.displayData()
	
func displayData():
	references["playerPos"].init("Player", currents["playerData"])
	references["candy1"].init("Candy 1", currents["levelData"].candy["1"])
	references["candy2"].init("Candy 2", currents["levelData"].candy["2"])
	references["candy3"].init("Candy 3", currents["levelData"].candy["3"])
	references["maxFunction"].init("Max Function", currents["levelData"].maxFunction)
	
func saveData():
	currents["playerData"] = references["playerPos"].getValue()
	currents["levelData"].candy["1"] = references["candy1"].getValue()
	currents["levelData"].candy["2"] = references["candy2"].getValue()
	currents["levelData"].candy["3"] = references["candy3"].getValue()
	currents["levelData"].maxFunction = references["maxFunction"].getValue()
	currents["sender"].saveLevelData(currents["playerData"], currents["levelData"])
	
func setPlayerData(playerData):
	if not playerData.empty():
		currents["playerData"] = {"x":playerData.x,"y":playerData.y,"z":playerData.z,"direction":playerData.direction}
	else:
		currents["playerData"] = {"x":0,"y":0,"z":0,"direction":"front"}
		
func setLevelData(levelData):
	if not levelData.empty():
		currents["levelData"] = levelData
	else:
		currents["levelData"] = {
									"candy":{
										"1": 0,
										"2": 0,
										"3": 0
									},
									"maxFunction":0
								}
	
func getPlayerData():
	return currents["playerData"]

func getLevelData():
	return currents["levelData"]