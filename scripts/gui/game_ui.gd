
extends "../abstract_gui.gd"

# member variables here, example:
# var a=2
# var b="textvar"

var MAX_FUNCTION = 9

func init():
	prefabs ={
		"pieceContainer": preload("res://gui/game_hud/piece_container.scn"),
		"piece": preload("res://gui/game_hud/piece.scn")
	}
	self.initCurrents()
	.init()
	self.resetGUI()
	
	
func initReferences():
	.initReferences()
	references["gameController"] = references["rootNode"].references["gameController"]
	references["playBtn"] = self.get_node("top/top_right/play_btn")
	references["newFuncBtn"] = self.get_node("right/top_right/newfunc_btn")
	references["pieceContainers"] = self.get_node("right/bot_right/piececontainer_scroll/piece_containers")
	references["toolbar"] = self.get_node("bot_center/toolbar_root")

func initCurrents():
	currents = {
		"solverAlgorithm":{},
		"pieceContainerIndex":1,
		"previewMode":false
	}
	
func initConnections():
	references["playBtn"].connect("pressed", self, "playSolverAlgorithm")
	references["newFuncBtn"].connect("pressed", self, "createNewPieceContainer")

func setPreviewMode(state):
	currents["previewMode"] = state

func reset():
	for pieceContainer in references["pieceContainers"].get_children():
		if pieceContainer.getLink() != "M":
			references["pieceContainers"].remove_child(pieceContainer)
		else:
			pieceContainer.reset()
	references["toolbar"].reset()
	currents["solverAlgorithm"] = {}

func createNewPieceContainer():
	if currents["pieceContainerIndex"] <= MAX_FUNCTION: 
		var tempPieceContainer = prefabs["pieceContainer"].instance()
		references["pieceContainers"].add_child(tempPieceContainer)
		tempPieceContainer.init("Function "+ str(currents["pieceContainerIndex"]),"F" + str(currents["pieceContainerIndex"]))
		references["toolbar"].addNewPiece("F" + str(currents["pieceContainerIndex"]))
		currents["pieceContainerIndex"]+=1
	pass

	
func resetGUI():
	self.reset()
	var texture = ImageTexture.new()
	texture.load("res://assets/gui/button/icon/play.png")
	references["playBtn"].set_button_icon(texture)
	
func extractSolverAlgorithm():
	var tempAlgorithm = {}
	var tempPieceArray ={}
	var index = 0
	for pieceContainerRoot in references["pieceContainers"].get_children():
		for piece in pieceContainerRoot.getPieceContainer().get_children():
			if piece.getAction() != "":
				tempPieceArray[str(index)] = piece.getAction()
				index+=1
		tempAlgorithm[str(pieceContainerRoot.getLink())] = tempPieceArray
		tempPieceArray = {}
		index = 0
	currents["solverAlgorithm"] = tempAlgorithm
	
func playSolverAlgorithm():
	if not references["gameController"].currents["HANDLE_SOLVER_ALGORITHM"]:
		self.extractSolverAlgorithm()
		references["gameController"].playSolverAlgorithm(currents["solverAlgorithm"])
		references["playBtn"].disconnect("pressed", self, "playSolverAlgorithm")
		references["playBtn"].connect("pressed", self, "resetMap")
		var texture = ImageTexture.new()
		texture.load("res://assets/gui/button/icon/rewind.png")
		references["playBtn"].set_button_icon(texture)

func setFocusedPiece(funcLink, index):
	if currents.has("focusPiece"):
		currents["focusPiece"].setFocus(false)
	if references["pieceContainers"].get_node(funcLink) != null:
		currents["focusPiece"] = references["pieceContainers"].get_node(funcLink).getPieceContainer().get_child(index)
		currents["focusPiece"].setFocus(true)
	pass

func resetMap():
	if not references["gameController"].currents["HANDLE_SOLVER_ALGORITHM"]:
		references["gameController"].resetMap()
		references["playBtn"].disconnect("pressed", self, "resetMap")
		references["playBtn"].connect("pressed", self, "playSolverAlgorithm")
		var texture = ImageTexture.new()
		texture.load("res://assets/gui/button/icon/play.png")
		references["playBtn"].set_button_icon(texture)

func isPreviewMode():
	return currents["previewMode"]