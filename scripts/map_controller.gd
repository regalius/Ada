
extends Node2D

const MAP_MAX_X = 64
const MAP_MAX_Y = 64

var prefabs = {
	"house":preload('res://object/building/house.scn'),
	"teleporter":preload('res://object/building/teleporter.scn')
}

var tileIndex = ["grass","path","house","teleporter"]

var references={
	"ground" : "",
	"object" : "",
	"playerCam" : "",
	"editorCam":"",
	"camera":"",
	"selector":"",
	"rootNode":"",
	"inputController":""
}
var currents ={
	"map":{},
	"camera":null,
	"IS_EDITOR_MODE": false,
	"SHOW_OBJECT":true
}

var objects = {
	"house":{},
	"teleporter":{}
}

func _ready():
	# Initialization here
	pass

func _input(event):
	references["inputController"]._input(event,self,"map")

func _fixed_process(delta):
	currents["camera"]._fixed_process(delta)
	pass
	
func init(root):
	self.initReferences(root)
	self.initGrid()
	references["grid"].hide()
#	self.saveMapToFile("workshopdefault")
	pass

func loadMap(path, editorMode):
	self.initCurrents(path, editorMode)

func initReferences(root):
	references["rootNode"] = root
	references["ground"] = self.get_node("ground")
	references["grid"] = self.get_node("grid")
	references["object"] = self.get_node("object")
	references["player"] = self.get_node("object/Player")
	references["playerCam"] = self.get_node("object/Player/camera")
	references["editorCam"] = self.get_node("editor_cam")
	references["selector"] = self.get_node("selector")
	references["inputController"] = root.references["inputController"]

func initCurrents(path, editorMode):
	currents["IS_EDITOR_MODE"] = editorMode
	currents["mapSize"] = Vector2(0,0)
	self.setEditorMode(editorMode)
	references["player"].init(self)
	self.loadMapFromFile(path)
#	self.ohoho()
#	self.ihihi()
	references["playerCam"].init(self)
	references["editorCam"].init(self)
#	self.ohoho()

func initGrid():
	for x in range(MAP_MAX_X):
		for y in range(MAP_MAX_Y):
			references["grid"].set_cell(x,y,0)

func ohoho():
	currents["map"].playerData = {"x":4,"y":2,"z":0,"direction":"front"}
	currents["map"].levelData = {
		"candy":{
					"1": 20,
					"2": 18,
					"3": 16
				},
		"maxFunction":2,
#		"tutorial":["grab_piece.move","drop_piece.move.F1.6","grab_piece.turnLeft","drop_piece.turnLeft.M.7","grab_piece.turnRight","drop_piece.turnRight.M.3","grab_piece.interact","drop_piece.interact.M.4","play_solver_algorithm"],
#		"conversation":[{
#							"condition":{"start":1},
#							"data":{
#									0:{"text":"Hello everyone! Can I use when creating TileMap advance Tile specify the animation to start when the scene is automatically start? I do not ...",
#										"name":"Ada",
#										"actor":"ada",
#										"emotion":"normal",
#										"currentAction":[["showFocusedItem",[true,"house"]]],
#										"nextAction":{1:[["showFocusedItem",[false,"house"]],["goTo",[1]]]}
#									},
#									1:{
#										"text":"Ini Teks 2 Lho",
#										"name":"Ada",
#										"actor":"ada",
#										"emotion":"normal",
#										"currentAction":[["showFocusedItem",[true,"teleporter"]]],
#										"nextAction":{1:[["showFocusedItem",[false,"teleporter"]],["goTo",[2]]]}
#									},
#									2:{
#										"text":"Howdy, my name is Lino",
#										"name":"Strange Flying Cat",
#										"actor":"lino",
#										"emotion":"normal",
#										"currentAction":[],
#										"nextAction":{1:[["showFocusedItem",[false,"teleporter"]],["goTo",[3]]]}
#									},
#									3:{
#										"text":"So you want me to repeat my explanation?",
#										"name":"Lino",
#										"actor":"lino",
#										"emotion":"normal",
#										"currentAction":[],
#										"nextAction":{	"Yes, please !":[["goTo",[2]]],
#														"No, I got it":[["endConversation",""]],
#														"Fuck Off":[["endConversation",""]]
#													}
#									}
#							}
#						},
#						{
#							"condition": {"gameover":1},
#							"data":{
#										
#									0:{"text":"Hello everyone! Can I use when creating TileMap advance Tile specify the animation to start when the scene is automatically start? I do not ...",
#										"name":"Ada",
#										"actor":"ada",
#										"emotion":"normal",
#										"currentAction":[["showFocusedItem",[true,"house"]]],
#										"nextAction":{1:[["showFocusedItem",[false,"house"]],["goTo",[1]]]}
#									},
#									1:{
#										"text":"Ini Teks 2 Lho",
#										"name":"Ada",
#										"actor":"ada",
#										"emotion":"normal",
#										"currentAction":[["showFocusedItem",[true,"teleporter"]]],
#										"nextAction":{1:[["showFocusedItem",[false,"teleporter"]],["goTo",[2]]]}
#									},
#									2:{
#										"text":"Howdy, my name is Lino",
#										"name":"Strange Flying Cat",
#										"actor":"lino",
#										"emotion":"normal",
#										"currentAction":[],
#										"nextAction":{1:[["showFocusedItem",[false,"teleporter"]],["goTo",[3]]]}
#									},
#									3:{
#										"text":"So you want me to repeat my explanation?",
#										"name":"Lino",
#										"actor":"lino",
#										"emotion":"normal",
#										"currentAction":[],
#										"nextAction":{1:[["endConversation",""],["showResultMenu",[""]]]}
#									}
#							}
#						}
#					]
	}
	currents["map"].mapData=[
#		{x=0,y=2,z=0,groundType= 1,objectAttribute={}},
#		{x=0,y=1,z=0,groundType= 2,objectAttribute={"houseValue" : 6, "direction": "left"}},
#		{x=1,y=1,z=0,groundType= 0,objectAttribute={}},
#		{x=2,y=1,z=0,groundType= 1,objectAttribute={}},
#		{x=3,y=1,z=0,groundType= 0,objectAttribute={}},
#		{x=4,y=1,z=0,groundType= 0,objectAttribute={}},
#		{x=1,y=2,z=0,groundType= 1,objectAttribute={}},
#		{x=2,y=2,z=0,groundType= 1,objectAttribute={}},
#		{x=3,y=2,z=0,groundType= 1,objectAttribute={}},
#		{x=4,y=2,z=0,groundType= 1,objectAttribute={}},
#		{x=0,y=3,z=0,groundType= 0,objectAttribute={}},
#		{x=1,y=3,z=0,groundType= 0,objectAttribute={}},
#		{x=2,y=3,z=0,groundType= 1,objectAttribute={}},
#		{x=4,y=3,z=0,groundType= 0,objectAttribute={}},
#		{x=0,y=4,z=0,groundType= 0,objectAttribute={}},
#		{x=1,y=4,z=0,groundType= 0,objectAttribute={}},
#		{x=2,y=4,z=0,groundType= 1,objectAttribute={}},
#		{x=3,y=4,z=0,groundType= 0,objectAttribute={}},
#		{x=4,y=4,z=0,groundType= 0,objectAttribute={}},
#		{x=0,y=5,z=0,groundType= 0,objectAttribute={}},
#		{x=1,y=5,z=0,groundType= 0,objectAttribute={}},
#		{x=2,y=5,z=0,groundType= 1,objectAttribute={}},
#		{x=3,y=5,z=0,groundType= 0,objectAttribute={}},
#		{x=4,y=5,z=0,groundType= 0,objectAttribute={}},
#		{x=0,y=6,z=0,groundType= 0,objectAttribute={}},
#		{x=1,y=6,z=0,groundType= 2,objectAttribute={"houseValue" : 16, "direction": "back"}},
#		{x=2,y=6,z=0,groundType= 1,objectAttribute={}},
#		{x=3,y=6,z=0,groundType= 0,objectAttribute={}},
#		{x=4,y=6,z=0,groundType= 0,objectAttribute={}},
	]
	
	self.loadMapData()

func ihihi():
	currents["map"].levelData.tutorial =["create_new_function","grab_piece.move","drop_piece.move.F1.1",
	"grab_piece.turnRight","drop_piece.turnRight.F1.2","grab_piece.interact","drop_piece.interact.F1.3",
	"grab_piece.turnLeft","drop_piece.turnLeft.F1.4","grab_piece.move","drop_piece.move.F1.5","grab_piece.interact","drop_piece.interact.F1.6",
	"grab_piece.F1","drop_piece.F1.F1.7","grab_piece.F1","drop_piece.F1.M.1","play_solver_algorithm"]
	currents["map"].levelData.conversation = [{
							"condition":{"start":1},
							"data":{
									"skipAction":[],
									0:{"text":"CONVERSATION_LOOPING1_START0",
										"name":"Lino",
										"actor":"lino",
										"emotion":"normal",
										"currentAction":[],
										"nextAction":{1:[["goTo",[1]]]}
									},
									1:{
										"text":"CONVERSATION_LOOPING1_START1",
										"name":"Ada",
										"actor":"ada",
										"emotion":"normal",
										"currentAction":[],
										"nextAction":{1:[["goTo",[2]]]}
									},
									2:{
										"text":"CONVERSATION_LOOPING1_START2",
										"name":"Lino",
										"actor":"lino",
										"emotion":"normal",
										"currentAction":[],
										"nextAction":{1:[["endConversation",""]]}
									}
							}
						},
						{
							"condition": {"gameover":1},
							"data":{
									"skipAction":[["showResultMenu",[""]]],
									0:{"text":"CONVERSATION_LOOPING1_END0",
										"name":"Ada",
										"actor":"ada",
										"emotion":"happy",
										"currentAction":[],
										"nextAction":{1:[["endConversation",""],["showResultMenu",[""]]]}
									}
							}
						}
					]
	
func setPreviewMode(state):
	if state:
		self.resetMap()
		self.setEditorMode(false)
		self.showObjects(currents["SHOW_OBJECT"])
	else:
		self.resetMap()
		self.setEditorMode(true)	
	pass

func clearMap():
	self.clearObjects()
	references["ground"].clear()

func loadMapData():
#Replace Existing Tilemap with currents["map"].mapData
	self.clearMap()
	for cell in currents["map"].mapData:
		references["ground"].set_cell(cell.x,cell.y,cell.groundType)
		if cell.x+1 > currents["mapSize"].x:
			currents["mapSize"].x = cell.x+1
		if cell.y+1 > currents["mapSize"].y:
			currents["mapSize"].y = cell.y+1
		
		self.spawnObject(cell)
	
	if currents["mapSize"] == Vector2(0,0) or self.isEditorMode():
		currents["mapSize"] = Vector2(MAP_MAX_X,MAP_MAX_Y)

	
	references["playerCam"].setMaxPos(self.getMapSize(), references["ground"].get_cell_size())
	references["editorCam"].setMaxPos(self.getMapSize(), references["ground"].get_cell_size())
	
	references["player"].setPosition(currents["map"].playerData, false)
	self.showObjects(currents["SHOW_OBJECT"])
	
func saveMapData():
# save current tilemap to currents["map"].mapData
	var temp=[]
	var tempGround=-1
	var tempAttribute = {}
	var tempType
	var z
	for x in range(MAP_MAX_X):
		for y in range(MAP_MAX_Y):
			if references["ground"].get_cell(x,y) > -1:
				tempGround = references["ground"].get_cell(x,y)
				z = 0
				tempType = getTileType(tempGround)
				
				if tempType != "" and objects.has(tempType):
					if objects[tempType].has("x"+str(x)+"y"+str(y)):
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
	currents["map"].mapData = temp
# save player position to map data
	var playerPos = references["player"].getPosition()
	currents["map"].playerData = {"x":playerPos.x,"y":playerPos.y,"z":playerPos.z,"direction":playerPos.direction}
	pass
	
	
func loadMapFromFile(filepath):
	#Load currents["map"].mapData from File
	
	print("Attempting to load map from: " + filepath)
	var data = references["rootNode"].readFromFile(filepath)
	if data != null :
		currents["map"]= data
		self.loadMapData()
		print("Load map from: " + filepath + " - SUCCESS")
		return true
	else:
		print("Load map from: " + filepath + " - FAILED")
		return false

func saveMapToFile(filepath):
	if self.validateFileName(filepath):
		self.saveMapData()
		references["rootNode"].writeToFile(filepath, currents["map"])
		print("Map saved to file: "+ filepath)
		return true
	else:
		print("Failed to Save Map - Wrong File Name")
		return false


func validateFileName(fileName):
	return true

func spawnObject(cell):
	var temp
	var tempType = self.getTileType(cell.groundType)
		
	if prefabs.has(tempType):
		temp = prefabs[tempType].instance()
		temp.set_pos(self.getWorldPosition(Vector2(cell.x,cell.y)))
		temp.init(references["ground"],cell)
		references["object"].add_child(temp)
		objects[tempType]["x"+str(cell.x)+"y"+str(cell.y)] = temp
		
		if not cell.objectAttribute.empty():
			temp.setObjectAttribute(cell.objectAttribute)
			
		temp = null

func removeObject(cell):
	for type in objects:
		if objects[type].has("x"+str(cell.x)+"y"+str(cell.y)):
			references["object"].remove_child(objects[type]["x"+str(cell.x)+"y"+str(cell.y)])
			objects[type]["x"+str(cell.x)+"y"+str(cell.y)].destroy(self)
			objects[type].erase("x"+str(cell.x)+"y"+str(cell.y))
	pass

func clearObjects():
	var i =0
	for type in objects:
		for coordinate in objects[type]:
			references["object"].remove_child(objects[type][coordinate])
			objects[type][coordinate].destroy(self)
		objects[type].clear()

func paint(mapPos, objectType, objectAttribute):
	var cell = {"x": mapPos.x, "y": mapPos.y, "z":0, "groundType": objectType,"objectAttribute":objectAttribute}
	if cell.x >= 0 and cell.x < MAP_MAX_X and cell.y >= 0 and cell.y < MAP_MAX_Y:  
		if references["ground"].get_cell(cell.x,cell.y) != objectType:		
			var previousCell = self.getMapDataCell(mapPos.x,mapPos.y,0)
			if previousCell == null:
				previousCell = {"x": mapPos.x, "y": mapPos.y, "z": 0, "groundType": -1, "objectAttribute":{}}
			references["ground"].set_cell(cell.x,cell.y,objectType)
			self.removeObject(cell)
			self.spawnObject(cell)
			self.setMapDataCell(cell)
			return previousCell
	return null
	
#func modifyAttribute(eventPos):
#	var mapPos = self.getMapPosition(eventPos)	
#	print(str(self.getObjectAt(mapPos).objectAttribute))

func showObjects(state):
	currents["SHOW_OBJECT"] = state
	if currents["SHOW_OBJECT"]:
		references["object"].show()
	else:
		references["object"].hide()

func updateWorld():
	for type in objects:
		for key in objects[type]:
			objects[type][key].updateObject()

func resetMap():
	references["player"].setPosition(currents["map"].playerData, false)
	references["playerCam"].reset()
	references["editorCam"].reset()
	for type in objects:
		for key in objects[type]:
			objects[type][key].resetObject()
	pass

func setEditorMode(state):
	currents["IS_EDITOR_MODE"] = state
	if currents["IS_EDITOR_MODE"]:
		currents["camera"] = references["editorCam"]
		references["selector"].show()
		references["grid"].show()

	else:
		currents["camera"] = references["playerCam"]
		currents["SHOW_OBJECT"] = true
		references["selector"].hide()
		references["grid"].hide()
	
	currents["camera"].make_current()

func setMapDataCell(cell):
	var index = self.getCellIndex(cell.x,cell.y,cell.z)
	if cell.groundType == -1:
#		print("delete "+ str(currents["map"].mapData[index]))
		currents["map"].mapData.remove(index)
	else:
#		print(index)
		if index == -1:
			currents["map"].mapData.append(cell)
		else:
			currents["map"].mapData.remove(index)
			currents["map"].mapData.insert(index,cell)

func setPlayerData(playerData):
	currents["map"].playerData = playerData
	
func setLevelData(levelData):
	currents["map"].levelData = levelData

func getWorldPosition(tilePos):
	return references["ground"].map_to_world(tilePos, false )

func getMapPosition(worldPos):
	var transform = get_viewport_transform().affine_inverse().xform(worldPos)
	var clickTile = references["ground"].world_to_map(transform)
	return Vector2(clickTile.x,clickTile.y)

func getPlayer():
	return references["player"]

func getCamera():
	return currents["camera"]
func getObject(type):
	if objects.has(type):
		return objects[type]
	else:
		return null

func getObjectAt(position):
	for type in objects:
		if objects[type].has("x"+str(position.x)+"y"+str(position.y)):
			return objects[type]["x"+str(position.x)+"y"+str(position.y)]

	return null

func getPlayerData():
	return currents["map"].playerData

func getLevelData():
	return currents["map"].levelData

func getMapData():
	return currents["map"].mapData

func getMapDataCell(x,y,z):
	for cell in currents["map"].mapData:
		if cell.x == x and cell.y == y and cell.z == z:
			return cell
	return null

func getCellIndex(x,y,z):
	for cell in currents["map"].mapData:
		if cell.x == x and cell.y == y and cell.z == z:
			return currents["map"].mapData.find(cell)
	return -1

func getTileType(index):
	if index > -1:
		return tileIndex[index]

func getTileIndex(type):
	return tileIndex.find(type)

func getMapSize():
	return currents["mapSize"]

func isEditorMode():
	return currents["IS_EDITOR_MODE"]

func isObjectShown():
	return currents["SHOW_OBJECT"]