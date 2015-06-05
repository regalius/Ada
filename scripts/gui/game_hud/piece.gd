
extends TextureButton

# member variables here, example:
# var a=2
# var b="textvar"
var references={
	"cursor":"",
	"rootNode":""
}
var prefabs = {
	"piece":preload("res://gui/game_hud/piece.scn")
}
var textureLibrary = {
	"empty":"res://assets_dummy/gui/piece_empty.png",
	"bg":"res://assets_dummy/gui/piece_bg.png",
	"move":"res://assets_dummy/gui/move_piece.png",
	"turnLeft":"res://assets_dummy/gui/turn_left_piece.png",
	"turnRight":"res://assets_dummy/gui/turn_right_piece.png",
	"interact":"res://assets_dummy/gui/deliver_piece.png",
#	"F1":"res://assets_dummy/gui/f1.png",
#	"F2":"res://assets_dummy/gui/f2.png"
}

export var action = ""
export var type = "transmitter"
export var IS_DRAG_PREVIEW = false

func _ready():
	# Initialization here
	self.init("")
	pass

func _input_event(event):
	references["rootNode"].references["inputController"]._input(event,self, "gui")

func init(act):
	self.initReferences()
	if act =="" and self.action !="":
		self.setAction(action)
	else:
		self.setAction(act)

func initReferences():
	if not IS_DRAG_PREVIEW:
		references["rootNode"] = self.get_node("/root").get_child(self.get_node("/root").get_child_count()-1)
		references["cursor"] = references["rootNode"].get_node("gui_layer/canvas_item/Cursor")

func get_drag_data(pos):
	var temp
	if action !="":
		var dragPreview = prefabs["piece"].instance()
		dragPreview.IS_DRAG_PREVIEW = true
		dragPreview.init(self.action)
		self.set_drag_preview(dragPreview)
		temp =action
#		references["cursor"].hide()
		if type =="receiver":
			self.setAction("")
		return temp
	
func drop_data(pos, data):
	if type=="receiver":
		self.setAction(data)
	

func setAction(act):
	var texture = ImageTexture.new()
	action = act
	if act !="":
		texture.load(textureLibrary["bg"])
		self.set_normal_texture(texture)
		if textureLibrary.has(act):
			var iconTexture = ImageTexture.new()
			iconTexture.load(textureLibrary[act])
			self.get_node("icon").set_texture(iconTexture)
			self.get_node("icon").show()
			self.get_node("label").hide()
		else:
			self.get_node("label").set_text(act)
			self.get_node("label").show()
			self.get_node("icon").hide()
			pass
	else:
		texture.load(textureLibrary["empty"])	
		self.set_normal_texture(texture)
		self.get_node("icon").hide()
		self.get_node("label").hide()
	

func getAction():
	return action


