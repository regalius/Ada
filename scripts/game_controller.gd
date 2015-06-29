var references = {
	"mapRoot":"",
	"guiRoot":"",
	"player": "",
	"map":"",
	"gameUI":"",
	"rootNode":""
}

const ACTION_WAIT_TIME =50

var currents = {}

func _fixed_process(delta):
	if not currents["LEVEL_COMPLETE"]:
		if currents["waitTime"] < ACTION_WAIT_TIME:
			currents["waitTime"]+=1
		else:
			self.handleSolverAlgorithm(delta)
	
	references["player"]._fixed_process(delta)
	references["mapRoot"]._fixed_process(delta)

func init(root):
	self.initReferences(root)
	references["rootNode"].set_fixed_process(true)
	self.startLevel()
	pass

func end(root):
	self.quitLevel()
	references["rootNode"].set_fixed_process(false)	
		
func initReferences(root):
	references["rootNode"] = root
	references["mapRoot"] = root.get_node("world_root/map_root")
	references["guiRoot"] =  root.get_node("gui_layer/canvas_item/gui_root")
	references["gameUI"] = references["guiRoot"].get_node("gui_container/gameui_root")
	references["conversationUI"] = references["guiRoot"].get_node("gui_container/conversationui_root")
	references["map"] = references["mapRoot"].get_node("ground")
	references["player"] = references["mapRoot"].get_node("object/Player")
	pass

func initCurrents():
	currents = {
		"solverAlgorithm":{},
		"actionIndex":0,
		"repeatIndex":0,
		"HANDLE_SOLVER_ALGORITHM":false,
		"LEVEL_COMPLETE":false,
		"waitTime":50,
		"levelData":"",
		"score":0,
		"candy":0,
		"IS_PREVIEW_MODE" : false
	}

func setPreviewMode(state):
	currents["IS_PREVIEW_MODE"] = state

func startLevel():
	self.initCurrents()
	currents["levelData"] = references["mapRoot"].getLevelData()
	references["gameUI"].init()
	references["gameUI"].setMaxFunction(currents["levelData"].maxFunction)
	references["mapRoot"].resetMap()
	references["player"].startGame()
	self.handleConversationEvent({"start":1})
	self.handleTutorial()

func quitLevel():
	if not currents["IS_PREVIEW_MODE"]:
		references["rootNode"].saveLevel(currents["score"],currents["candy"])
		if currents["LEVEL_COMPLETE"]:
			references["rootNode"].unlockLevel(references["rootNode"].getNextLevel())
	references["guiRoot"].showConversation(false, self, "")
	references["guiRoot"].showTutorial(false,self,"")

	pass

func retryLevel():
	currents["LEVEL_COMPLETE"] = false
	references["guiRoot"].showDialog(false,self,"gameResult","")
	pass

func startNextLevel():
	references["rootNode"].startLevel(references["rootNode"].getNextLevel())

func showResultMenu():
	references["guiRoot"].showDialog(true,self,"gameResult", [currents["score"],currents["candy"], currents["IS_PREVIEW_MODE"]])

func playSolverAlgorithm(solverAlgorithm):
	references["mapRoot"].resetMap()
	currents["solverAlgorithm"]= solverAlgorithm
#	print(str(currents["solverAlgorithm"]))
	currents["HANDLE_SOLVER_ALGORITHM"] = true
	currents["actionIndex"] = 0
	currents["repeatIndex"] = 0

func resetMap():
	references["mapRoot"].resetMap()

func rewindSolverAlgorithm():
	currents["HANDLE_SOLVER_ALGORITHM"] = false
	currents["actionIndex"] = 0
	currents["repeatIndex"] = 0
	self.resetMap()

func fetchCurrentAction(link):
	var index = 0
	for i in range(index, currents["solverAlgorithm"][link].size()):
		var action =currents["solverAlgorithm"][link][str(i)]
		if self.isAction(action):
			if currents["actionIndex"] == currents["repeatIndex"]:
				references["gameUI"].setFocusedPiece(link,i)
				currents["actionIndex"]+=1
				return action
			currents["repeatIndex"]+=1
		else:
			var act = self.fetchCurrentAction(action)
			if isAction(act):
				return act 

func gameOver():
	currents["score"] = currents["actionIndex"]

	if currents["actionIndex"] <= currents["levelData"]["candy"]["3"]:
		currents["candy"] = 3
	elif currents["actionIndex"] <= currents["levelData"]["candy"]["3"]:
		currents["candy"] = 2
	elif currents["actionIndex"] <= currents["levelData"]["candy"]["1"]:
		currents["candy"] = 1
	else:
		currents["candy"] = 0
				
	if self.handleConversationEvent({"gameover":1}) == null:
		self.showResultMenu()
#	if currents["levelData"].has("finishConversation"):
#		references["guiRoot"].showConversation(true, self, currents["levelData"].finishConversation)
#	else:
#		

func isAction(action):
	if action == "move" or action == "turnLeft" or action == "turnRight" or action == "interact":
		return true
	else:
		return false

func isGameOver():
	var houses = references["mapRoot"].getObject("house")
	for key in houses:
		if not houses[key].isDelivered():
			return false
	return true

func handleSolverAlgorithm(delta):
	if currents["HANDLE_SOLVER_ALGORITHM"]:
		if references["player"].getCurrentActionState() == "idle":
			var act = self.fetchCurrentAction("M")
			if act!= null:
				currents["waitTime"] = 0
				currents["repeatIndex"] = 0
				references["player"].doAction(act)
				if act == "interact":
					currents["LEVEL_COMPLETE"] = self.isGameOver()
					if currents["LEVEL_COMPLETE"]:
						self.gameOver()
				references["mapRoot"].updateWorld()
			else:
				currents["HANDLE_SOLVER_ALGORITHM"] = false
				references["gameUI"].setFocusedPiece("null",-1)

func handleConversationEvent(condition):
	if currents["levelData"].has("conversation"):
		var currentConversation = null
		for conversation in currents["levelData"].conversation:
			if currentConversation == null:
				var isTargetedConversation = true 
				for param in condition: 
					if isTargetedConversation:
						if conversation.condition.has(param):
							if not condition[param] ==conversation.condition[param]:
								isTargetedConversation = false
						else:
							isTargetedConversation = false
				if isTargetedConversation:
					currentConversation = conversation
					
		if currentConversation != null:
			references["guiRoot"].showConversation(true, self, currentConversation.data)
			
		return currentConversation

func handleTutorial():
	if currents["levelData"].has("tutorial"):
		references["guiRoot"].showTutorial(true,self,currents["levelData"].tutorial)