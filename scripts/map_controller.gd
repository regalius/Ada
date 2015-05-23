
extends Node2D

const MAP_MAX_X = 64
const MAP_MAX_Y = 64

const GRASS_TILE_INDEX = 0
const PATH_TILE_INDEX = 1
const HOUSE_TILE_INDEX = 2

var file = File.new()

var prefabs = {
	"house":preload('res://object/building/house.scn')
}

var references={
	"ground" : "",
	"object" : "",
	"player" : "",
	"camera":"",
	"rootNode":"",
	"gameController":"",
	"inputController":""
}
var currents ={
	"playerData":"",
	"levelData":"",
	"mapData":[]
}

var objects = {
	"house":{}
}

func _ready():
	# Initialization here
	pass

func _input(event):
	references["inputController"]._input(event,self,"map")

func _fixed_process(delta):
	pass
	
func init(root, path):
	self.initReferences(root)
	self.initCurrents(path)
	self.loadMapData()
#	self.saveMapToFile("procedural2")
	pass

func initReferences(root):
	references["rootNode"] = root
	references["ground"] = self.get_node("ground")
	references["object"] = self.get_node("object")
	references["player"] = self.get_node("object/Player")
	references["camera"] = self.get_node("object/Player/camera")
	references["gameController"] = root.references["gameController"]
	references["inputController"] = root.references["inputController"]

func initCurrents(path):
	self.loadMapFromFile(path)	
#	currents["playerData"] = {"x":4,"y":2,"z":0,"direction":"front"}
#	currents["levelData"] = {
#		"candy":{
#			"1": 20,
#			"2": 18,
#			"3": 16
#		}
#	}
#	currents["mapData"]=[
#		{x=0,y=2,z=0,groundType= 1,objectAttribute=[]},
#		{x=0,y=1,z=0,groundType= 2,objectAttribute={"houseValue" : 6, "direction": "left"}},
#		{x=1,y=1,z=0,groundType= 0,objectAttribute=[]},
#		{x=2,y=1,z=0,groundType= 1,objectAttribute=[]},
#		{x=3,y=1,z=0,groundType= 0,objectAttribute=[]},
#		{x=4,y=1,z=0,groundType= 0,objectAttribute=[]},
#		{x=1,y=2,z=0,groundType= 1,objectAttribute=[]},
#		{x=2,y=2,z=0,groundType= 1,objectAttribute=[]},
#		{x=3,y=2,z=0,groundType= 1,objectAttribute=[]},
#		{x=4,y=2,z=0,groundType= 1,objectAttribute=[]},
#		{x=0,y=3,z=0,groundType= 0,objectAttribute=[]},
#		{x=1,y=3,z=0,groundType= 0,objectAttribute=[]},
#		{x=2,y=3,z=0,groundType= 1,objectAttribute=[]},
#		{x=4,y=3,z=0,groundType= 0,objectAttribute=[]},
#		{x=0,y=4,z=0,groundType= 0,objectAttribute=[]},
#		{x=1,y=4,z=0,groundType= 0,objectAttribute=[]},
#		{x=2,y=4,z=0,groundType= 1,objectAttribute=[]},
#		{x=3,y=4,z=0,groundType= 0,objectAttribute=[]},
#		{x=4,y=4,z=0,groundType= 0,objectAttribute=[]},
#		{x=0,y=5,z=0,groundType= 0,objectAttribute=[]},
#		{x=1,y=5,z=0,groundType= 0,objectAttribute=[]},
#		{x=2,y=5,z=0,groundType= 1,objectAttribute=[]},
#		{x=3,y=5,z=0,groundType= 0,objectAttribute=[]},
#		{x=4,y=5,z=0,groundType= 0,objectAttribute=[]},
#		{x=0,y=6,z=0,groundType= 0,objectAttribute=[]},
#		{x=1,y=6,z=0,groundType= 2,objectAttribute={"houseValue" : 16, "direction": "back"}},
#		{x=2,y=6,z=0,groundType= 1,objectAttribute=[]},
#		{x=3,y=6,z=0,groundType= 0,objectAttribute=[]},
#		{x=4,y=6,z=0,groundType= 0,objectAttribute=[]},
#	]
	
func loadMapData():
#Replace Existing Tilemap with currents["mapData"]
	var temp
	references["ground"].clear()
	
	for cell in currents["mapData"]:
		references["ground"].set_cell(cell.x,cell.y,cell.groundType)
#Generate Object	
		if cell.groundType == HOUSE_TILE_INDEX:
			temp = prefabs["house"].instance()
			if temp:
				temp.set_pos(references["ground"].map_to_world(Vector2(cell.x,cell.y)))
				temp.init(references["ground"],cell)
				references["object"].add_child(temp)
				objects.house["x"+str(cell.x)+"y"+str(cell.y)] = temp
				temp = null
	references["player"].init(self,currents["playerData"])
	
func loadMapFromFile(filePath):
	#Load currents["mapData"] from File
	print("Attempting to load map from: " + filePath)
	if file.file_exists(filePath) :
		file.open(filePath, File.READ)
		currents["playerData"] = file.get_var()
		currents["levelData"] = file.get_var()
		currents["mapData"] = file.get_var()
		print("Load map from: " + filePath + " - SUCCESS")
		file.close()
		return true
	else:
		print("Load map from: " + filePath + " - FAILED")
		return false

func saveMapToFile(fileName):
	var temp=[]
	var tempGround=-1
	var tempAttribute = []
	var tempType = ""
	var z
	print("Attempting to save current map data to file: user://maps/" + fileName + ".acdmap")
	for x in range(MAP_MAX_X):
		for y in range(MAP_MAX_Y):
			if references["ground"].get_cell(x,y) > -1:
				tempGround = references["ground"].get_cell(x,y)
				z = 0
				
				if tempGround == HOUSE_TILE_INDEX:
					tempType = "house"
				
				if tempType != "" and objects[tempType].has("x"+str(x)+"y"+str(y)):
					tempAttribute = objects[tempType]["x"+str(x)+"y"+str(y)].getObjectAttribute()
					z = objects[tempType]["x"+str(x)+"y"+str(y)].getPosition().z

				temp.append({
					x=x,y=y,z=z,
					groundType= tempGround,
					objectAttribute=tempAttribute
				})
			tempGround = -1
			tempAttribute = []
			tempType=""
	
	if self.validateFileName(fileName):
		file.open("user://maps/" + fileName+".acdmap", File.WRITE)
		file.store_var(currents["playerData"])
		file.store_var(currents["levelData"])
		file.store_var(temp)
		file.close()
		print("Map saved to file: user://"+ fileName + ".acdmap")
		return true
	else:
		print("Failed to Save Map - Wrong File Name")
		return false

func validateFileName(fileName):
	return true

func updateWorld():
	for type in objects:
		for key in objects[type]:
			objects[type][key].updateObject()

func resetMap():
	references["player"].setPosition(currents["playerData"])
	for type in objects:
		for key in objects[type]:
			objects[type][key].resetObject()
	pass

func getObject(type):
	if objects.has(type):
		return objects[type]
	else:
		return false

func getObjectAt(type,x,y):
	if objects[type].has("x"+str(x)+"y"+str(y)):
		return objects[type]["x"+str(x)+"y"+str(y)]
	else:
		return false 

func getPlayerData():
	return currents["playerData"]

func getLevelData():
	return currents["levelData"]

func getMapData():
	return currents["mapData"]