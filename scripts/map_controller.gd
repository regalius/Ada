
extends Node2D

const MAP_MAX_X = 64
const MAP_MAX_Y = 64

const MAX_ZOOM = 1
const MIN_ZOOM = 10
const ZOOM_SPEED = .1

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
	"gameController":""
}
var currents ={
	"playerData":"",
	"levelData":"",
	"mapData":[],
	"zoomLevel":0
}

var objects = {
	"house":[]
}

func _ready():
	# Initialization here
#	self.set_process_input(true)
	pass
	
func init(root, path):
	self.initReferences(root)
	self.initCurrents(path)
	self.loadMapData()
#	self.saveMapToFile("kampret")

	pass

func initReferences(root):
	references["rootNode"] = root
	references["ground"] = self.get_node("ground")
	references["object"] = self.get_node("object")
	references["player"] = self.get_node("object/Player")
	references["camera"] = self.get_node("object/Player/camera")
	references["gameController"] = root.references["gameController"]

func initCurrents(path):
#	self.loadMapFromFile(path)	
	currents["playerData"] = {"x":0,"y":2,"z":0,"direction":"right"}
	currents["levelData"] = {}
	currents["mapData"]=[
		{x=0,y=2,groundType= 1,objectAttribute=[]},
		{x=0,y=1,groundType= 2,objectAttribute={"houseValue" : 4}},
		{x=1,y=1,groundType= 0,objectAttribute=[]},
		{x=2,y=1,groundType= 0,objectAttribute=[]},
		{x=3,y=1,groundType= 0,objectAttribute=[]},
		{x=4,y=1,groundType= 0,objectAttribute=[]},
		{x=1,y=2,groundType= 1,objectAttribute=[]},
		{x=2,y=2,groundType= 1,objectAttribute=[]},
		{x=3,y=2,groundType= 1,objectAttribute=[]},
		{x=4,y=2,groundType= 1,objectAttribute=[]},
		{x=0,y=3,groundType= 0,objectAttribute=[]},
		{x=1,y=3,groundType= 0,objectAttribute=[]},
		{x=2,y=3,groundType= 0,objectAttribute=[]},
		{x=3,y=3,groundType= 0,objectAttribute=[]},
		{x=4,y=3,groundType= 0,objectAttribute=[]},
	]
	currents["zoomLevel"] = references["camera"].get_zoom().x

	
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
				temp.init(references["ground"], cell.objectAttribute)
				references["object"].add_child(temp)
				objects["house"].append(temp)
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
	print("Attempting to save current map data to file: user://maps/" + fileName + ".acdmap")
	for x in range(MAP_MAX_X):
		for y in range(MAP_MAX_Y):
			if references["ground"].get_cell(x,y) > -1:
				tempGround = references["ground"].get_cell(x,y)
				
				if tempGround == HOUSE_TILE_INDEX:
					tempType = "house"
				
				if tempType != "":
					for house in objects["house"]:
						if house.isPosition(x,y):
							tempAttribute = house.getObjectAttribute()
				
				temp.append({
					x=x,y=y,
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
	
func getAdjacentTile(position, dir):
	var direction
	if position.direction:
		direction = position.direction
	else:
		direction = dir

	if direction=="front":
		return references["ground"].get_cell(position.x-1, position.y)
	elif direction=="back":
		return references["ground"].get_cell(position.x+1, position.y)
	elif direction=="right":
		return references["ground"].get_cell(position.x, position.y-1)
	elif direction=="left":
		return references["ground"].get_cell(position.x, position.y+1)

func zoom(command):
	if command =="in" and currents["zoomLevel"] > MAX_ZOOM:
		currents["zoomLevel"] -= ZOOM_SPEED
		references["camera"].set_zoom(Vector2(currents["zoomLevel"],currents["zoomLevel"]))
		pass
	elif command =="out" and currents["zoomLevel"] < MIN_ZOOM:
		currents["zoomLevel"] += ZOOM_SPEED
		references["camera"].set_zoom(Vector2(currents["zoomLevel"],currents["zoomLevel"]))
		pass