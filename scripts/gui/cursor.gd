
extends Sprite

# member variables here, example:
# var a=2
# var b="textvar"

func _ready():
	# Initialization here
	set_process_input(true)
	pass

func _input(event):
	if event.type == InputEvent.MOUSE_BUTTON:
		if (event.button_index == BUTTON_LEFT):
				if event.pressed:
					self.set_frame(1)
				else:
					self.set_frame(0)
	if (event.type == InputEvent.MOUSE_MOTION):
		self.set_pos(Vector2(event.x, event.y))

