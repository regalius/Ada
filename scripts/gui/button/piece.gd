
extends TextureButton

# member variables here, example:
# var a=2
# var b="textvar"

var textureLibrary = {
	"move":"res://assets_dummy/gui/move.png",
	"turnLeft":"res://assets_dummy/gui/turn_left.png",
	"turnRight":"res://assets_dummy/gui/turn_right.png",
	"deliver":"res://assets_dummy/gui/deliver.png"
}

export var action = ""

func _ready():
	# Initialization here
	self.init("move")
	pass

func init(act):
	self.setAction(act)
	
	
func get_drag_data(pos):
	var dragPreview = TextureButton.new()
	dragPreview.set_normal_texture(self.get_normal_texture())
	dragPreview.set_size(self.get_size())
	set_drag_preview(dragPreview)
	return action

func setAction(act):
	if act !="":
		action = act
		var texture = ImageTexture.new()
		texture.load(textureLibrary[act])
		self.set_normal_texture(texture)

func getAction():
	return action