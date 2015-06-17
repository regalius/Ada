
extends Sprite

var references={
	"rootNode":""
}

func _ready():
	# Initialization here
	self.set_process_input(true)
	self.initReferences()
	self.show()
	pass

func _input(event):
	if event.type == InputEvent.MOUSE_BUTTON:
		if (event.button_index == BUTTON_LEFT):
				if event.pressed:
					self.set_frame(1)
				else:
					self.set_frame(0)
	if event.type == InputEvent.MOUSE_MOTION:
		self.set_pos(Vector2(event.x, event.y))

func initReferences():
	references["rootNode"] = self.get_node("/root").get_child(self.get_node("/root").get_child_count()-1)

func show():
	if references["rootNode"].currents["CURSOR_ENABLED"]:
		.show()
	else:
		.hide()