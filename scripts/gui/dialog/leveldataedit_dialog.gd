
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
	references["playerx"] = self.get_node("itemscroll_container/item_container/player_x")
	references["playery"] = self.get_node("itemscroll_container/item_container/player_y")
	references["playerdirection"] = self.get_node("itemscroll_container/item_container/player_dir")
	references["candy1"] = self.get_node("itemscroll_container/item_container/candy_1")
	references["candy2"] = self.get_node("itemscroll_container/item_container/candy_2")
	references["candy3"] = self.get_node("itemscroll_container/item_container/candy_3")
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
	references["playerx"].init("Player X", currents["playerData"].x)
	references["playery"].init("Player Y", currents["playerData"].y)
	references["playerdirection"].init("Player Direction", currents["playerData"].direction)
	references["candy1"].init("Candy 1", currents["levelData"].candy["1"])
	references["candy2"].init("Candy 2", currents["levelData"].candy["2"])
	references["candy3"].init("Candy 3", currents["levelData"].candy["3"])
	pass
	
func saveData():
	currents["playerData"].x = references["playerx"].getValue()
	currents["playerData"].y = references["playery"].getValue()
	currents["playerData"].direction = references["playerdirection"].getValue()
	currents["levelData"].candy["1"] = references["candy1"].getValue()
	currents["levelData"].candy["2"] = references["candy2"].getValue()
	currents["levelData"].candy["3"] = references["candy3"].getValue()
	currents["sender"].saveLevelData(currents["playerData"], currents["levelData"])
	pass
	
func setPlayerData(playerData):
	if not playerData.empty():
		currents["playerData"] = {"x":playerData.x,"y":playerData.y,"z":playerData.z,"direction":playerData.direction}
	else:
		currents["playerData"] = {"x":0,"y":0,"z":0,"direction":"front"}
		
func setLevelData(levelData):
	if not levelData.empty():
		currents["levelData"] = {
									"candy":{
										"1": levelData["candy"]["1"],
										"2": levelData["candy"]["2"],
										"3": levelData["candy"]["3"]
									}
								}
	else:
		currents["levelData"] = {
									"candy":{
										"1": 0,
										"2": 0,
										"3": 0
									}
								}
	
func getPlayerData():
	return currents["playerData"]

func getLevelData():
	return currents["levelData"]