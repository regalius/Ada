
extends "../abstract_gui.gd"

# member variables here, example:
# var a=2
# var b="textvar"

var MAX_FUNCTION = 10

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
	references["playBtn"] = self.get_node("top/top_right/play_btn")
	references["backBtn"] = self.get_node("top/top_left/back_btn")
	references["newFuncBtn"] = self.get_node("right/top_right/newfunc_btn")
	references["pieceContainers"] = self.get_node("right/piececontainer_scroll/piece_containers")
	references["toolbar"] = self.get_node("bot_center/toolbar_root")

func initCurrents():
	currents = {
		"solverAlgorithm":{},
		"pieceContainerIndex":1
	}
	
func initConnections():
	references["backBtn"].connect("pressed", self.get_parent(), "buttonPressed",["showDialog",[true,"levelMenu"]])
	references["playBtn"].connect("pressed", self, "playSolverAlgorithm")
	references["newFuncBtn"].connect("pressed", self, "createNewPieceContainer")

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
	texture.load("res://assets_dummy/gui/play.png")
	references["playBtn"].set_normal_texture(texture)
	references["playBtn"].set_pressed_texture(texture)
	
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
	if not references["rootNode"].references["gameController"].currents["HANDLE_SOLVER_ALGORITHM"]:
		self.extractSolverAlgorithm()
		self.get_parent().buttonPressed("playSolverAlgorithm",[currents["solverAlgorithm"]])
		references["playBtn"].disconnect("pressed", self, "playSolverAlgorithm")
		references["playBtn"].connect("pressed", self, "resetMap")
		var texture = ImageTexture.new()
		texture.load("res://assets_dummy/gui/rewind.png")
		references["playBtn"].set_normal_texture(texture)
		references["playBtn"].set_pressed_texture(texture)

	
func resetMap():
	if not references["rootNode"].references["gameController"].currents["HANDLE_SOLVER_ALGORITHM"]:
		self.get_parent().buttonPressed("resetMap","")
		references["playBtn"].disconnect("pressed", self, "resetMap")
		references["playBtn"].connect("pressed", self, "playSolverAlgorithm")
		var texture = ImageTexture.new()
		texture.load("res://assets_dummy/gui/play.png")
		references["playBtn"].set_normal_texture(texture)
		references["playBtn"].set_pressed_texture(texture)
