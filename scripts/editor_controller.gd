var references = {
	"mapRoot":"",
	"guiRoot":"",
	"camera":"",
	"map":"",
	"editorUI":"",
	"rootNode":""
}

var currents = {
	"brushType":-1,
	"brushMode":"paint"
}
var tutorialArray = ["editor_tutorial"]
var conversationDict ={
						"skipAction":[["endConversation",""]],
						0:{	"text":"CONVERSATION_EDITOR_START0",
							"name":"Lino",
							"actor":"lino",
							"emotion":"normal",
							"currentAction":[],
							"nextAction":{1:[["goTo",[1]]]}
						},
						1:{
							"text":"CONVERSATION_EDITOR_START1",
							"name":"Ada",
							"actor":"ada",
							"emotion":"happy",
							"currentAction":[],
							"nextAction":{1:[["goTo",[2]]]}
						},
						2:{
							"text":"CONVERSATION_EDITOR_START2",
							"name":"Lino",
							"actor":"lino",
							"emotion":"happy",
							"currentAction":[],
							"nextAction":{1:[["endConversation",""]]}
						}
}

var history = []

func _fixed_process(delta):
	references["mapRoot"]._fixed_process(delta)
	references["camera"]._fixed_process(delta)
	pass

func init(root):
	self.initReferences(root)
	self.initCurrents()
	history.clear()
#	references["mapRoot"].resetMap()
	references["camera"].set_zoom(references["camera"].INITIAL_ZOOM)
	references["rootNode"].set_fixed_process(true)
	references["editorUI"].init()
	if references["rootNode"].getUserdata().TUTORIAL_ON:
		self.showConversation()
		self.showTutorial()
		references["rootNode"].getUserdata().TUTORIAL_ON = false
	pass

func end(root):
	references["rootNode"].set_fixed_process(false)
		
func initReferences(root):
	references["rootNode"] = root
	references["mapRoot"] = root.get_node("world_root/map_root")
	references["guiRoot"] =  root.get_node("gui_layer/canvas_item/gui_root")
	references["editorUI"] = references["guiRoot"].get_node("gui_container/editorui_root")
	references["tutorialUI"] = references["guiRoot"].get_node("gui_container/tutorial_root")
	references["map"] = references["mapRoot"].get_node("ground")
	references["camera"] = references["mapRoot"].currents["camera"]
	pass

func initCurrents():
	currents["brushType"] = -1
	currents["brushMode"] = "paint"
	currents["filename"] = ""
	currents["SAVED"] = true
	pass

func handleBrushAction(position):
	currents["SAVED"] = false
	self.editMap(currents["brushMode"], [position])

func editMap(action, parameter):
	if action == "paint":
		self.paint(parameter[0])
	elif action == "modifyAttribute":
		self.modifyAttribute(parameter[0])
		
func paint(position):
	var mapPos = references["mapRoot"].getMapPosition(position)
	var previousCell = references["mapRoot"].paint(mapPos,currents["brushType"], {})
	if previousCell != null:
		self.addToHistory({"action": "paint", "previousCell": previousCell})
	
func modifyAttribute(position):
	var mapPos = references["mapRoot"].getMapPosition(position)
	var object = references["mapRoot"].getObjectAt(mapPos)
	if object != null:
		var type = object.getType()
		var groundType = references["mapRoot"].getTileIndex(type)
		var cell = {"x":mapPos.x,"y":mapPos.y,"z":0,"groundType":groundType,"objectAttribute":object.objectAttribute}
		references["guiRoot"].showDialog(true, self, "objectEdit", [type,cell])
#	print(str(references["mapRoot"].getObjectAt(mapPos).objectAttribute))

func saveAttribute(cell):
	var position = Vector2(cell.x,cell.y)
	var object = references["mapRoot"].getObjectAt(position)
	references["mapRoot"].setMapDataCell(cell)
	object.setObjectAttribute(cell.objectAttribute)
	references["guiRoot"].showDialog(false, self, "objectEdit", "")

func modifyLevelData():
	var playerData = references["mapRoot"].getPlayerData()
	var levelData = references["mapRoot"].getLevelData()
	references["guiRoot"].showDialog(true, self, "levelDataEdit", [playerData,levelData])
	pass
	
func saveLevelData(playerData,levelData):
	if references["mapRoot"].getPlayer().setPosition(playerData,false):
		references["mapRoot"].setPlayerData(playerData)
	references["mapRoot"].setLevelData(levelData)
	references["guiRoot"].showDialog(false, self, "levelDataEdit", "")
	pass

func loadMap(confirmed, filename):
	if confirmed:
		if not references["mapRoot"].loadMapFromFile(references["rootNode"].getUserMapPath(currents["filename"])):
			references["guiRoot"].showDialog(true,self,"alert",["Failed to load map, map doesn't exist"])
	elif filename != "":
		currents["filename"] = filename
		references["guiRoot"].showDialog(true, self, "yesno", ["loadMap"])
	pass
	
func saveMap(confirmed, filename):
	if confirmed:
		if not references["mapRoot"].saveMapToFile(references["rootNode"].getUserMapPath(currents["filename"])):
			references["guiRoot"].showDialog(true,self,"alert",["Failed to save map"])
		else:
			currents["SAVED"] = true
	elif filename != "":
		currents["filename"] = filename
		references["guiRoot"].showDialog(true, self, "yesno", ["saveMap"])
	pass

func playMap(confirmed, filename):
	if confirmed:
		if not references["mapRoot"].saveMapToFile(references["rootNode"].getUserMapPath(currents["filename"])):
			references["guiRoot"].showDialog(true,self,"alert",["Failed to save map"])
		else:
			currents["SAVED"] = true
			references["rootNode"].startPreviewMode()
	elif not currents["SAVED"] and filename != "":
		currents["filename"] = filename
		references["guiRoot"].showDialog(true, self, "yesno", ["playMap"])
	elif filename == "":
		self.playWithoutSave(false)
	elif currents["SAVED"]:
		references["rootNode"].startPreviewMode()		
	pass

func playWithoutSave(confirmed):
	if confirmed:
		references["rootNode"].startPreviewMode()
	else:
		references["guiRoot"].showDialog(true, self, "yesno", ["playWithoutSave"])
		
func toggleObject():
	if references["mapRoot"].isObjectShown():
		references["mapRoot"].showObjects(false)
	else:
		references["mapRoot"].showObjects(true)

func undo():
	if not history.empty():
		var action = history[history.size()-1]
		var position = Vector2(action.previousCell.x,action.previousCell.y)
		references["mapRoot"].paint(position, action.previousCell.groundType, action.previousCell.objectAttribute)
		history.remove(history.size()-1)
	
func addToHistory(action):
	if history.size() > 10:
		history.remove(0)
		
	history.append(action)

func setActiveBrush(mode, type):
	currents["brushMode"] = mode
	currents["brushType"] = type 

func getActiveBrush():
	return currents["brushType"]

func isSaved():
	return currents["SAVED"]
	
func showTutorial():
	references["guiRoot"].showTutorial(true,self,tutorialArray)

func showConversation():
	references["guiRoot"].showConversation(true,self,conversationDict)