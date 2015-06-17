
extends "../button.gd"

# member variables here, example:
# var a=2
# var b="textvar"
var prefabs = {
	"piece":preload("res://gui/game_hud/piece.scn")
}
var textureLibrary = {
	"move":"res://assets/gui/button/icon/move.png",
	"turnLeft":"res://assets/gui/button/icon/turn_left.png",
	"turnRight":"res://assets/gui/button/icon/turn_right.png",
	"interact":"res://assets/gui/button/icon/interact.png",
#	"F1":"res://assets_dummy/gui/f1.png",
#	"F2":"res://assets_dummy/gui/f2.png"
}

export var action = ""
export var type = "transmitter"
export var IS_DRAG_PREVIEW = false

func _ready():
	# Initialization here
	self.init()
	pass

func _input_event(event):
	references["rootNode"].references["inputController"]._input(event,self, "gui")

func init():
	self.initReferences()
	self.setAction(action)

func initReferences():
	if not IS_DRAG_PREVIEW:
		references["rootNode"] = self.get_node("/root").get_child(self.get_node("/root").get_child_count()-1)
		references["cursor"] = references["rootNode"].get_node("gui_layer/canvas_item/Cursor")

func get_drag_data(pos):
	var temp
	if action !="":
		var dragPreview = prefabs["piece"].instance()
		dragPreview.IS_DRAG_PREVIEW = true
		dragPreview.setAction(self.action)
		dragPreview.init()
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
		if textureLibrary.has(act):
			var iconTexture = ImageTexture.new()
			iconTexture.load(textureLibrary[act])
			self.set_button_icon(iconTexture)
			self.set_text("")
		else:
			self.set_text(act)
			self.set_button_icon(null)
			pass
		self.set_disabled(false)
	else:
		self.set_button_icon(null)
		self.set_text("")
		self.set_disabled(true)
	self.set_focus_mode(Control.FOCUS_NONE)
	
func setFocus(state):
	if state:
		self.set_focus_mode(Control.FOCUS_ALL)
		self.grab_focus()
	else:
		self.set_focus_mode(Control.FOCUS_NONE)
	
func getAction():
	return action


