
extends Control

# member variables here, example:
# var a=2
# var b="textvar"

#var references = {
#	""
#}

var prefabs = {
	"piece" : preload("res://gui/game_hud/piece.scn")
}
var references = {
	"pieceContainer":"",
	"funcPieceContainer":""
}

func _ready():
	# Initialization here
	self.init()
	pass

func init():
	self.initReferences()

func initReferences():
	references["pieceContainer"] = self.get_node("container/piece_container/container")
	references["funcPieceContainer"] = self.get_node("container/func_container/container")
	
func addNewPiece(funcLink):
	var tempPiece = prefabs["piece"].instance()
	references["funcPieceContainer"].add_child(tempPiece)
	tempPiece.setAction(funcLink)
	tempPiece.init()
	if references["funcPieceContainer"].get_columns() < 10:
		references["funcPieceContainer"].set_columns(references["funcPieceContainer"].get_columns()+1)

func reset():
	for piece in references["funcPieceContainer"].get_children():
		references["funcPieceContainer"].remove_child(piece)
	pass
