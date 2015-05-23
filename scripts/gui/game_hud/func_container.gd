
extends GridContainer

# member variables here, example:
# var a=2
# var b="textvar"

var prefabs = {
	"piece" : preload("res://gui/game_hud/piece.scn")
}

var references = {
}

func _ready():
	# Initialization here
	self.init()
	pass

func init():
	self.set_columns(0)

func addNewPiece(funcLink):
	var tempPiece = prefabs["piece"].instance()
	self.add_child(tempPiece)
	tempPiece.init(funcLink)
	self.set_columns(self.get_columns()+1)


