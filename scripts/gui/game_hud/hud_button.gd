
extends TextureButton

# member variables here, example:
# var a=2
# var b="textvar"

func _ready():
	# Initialization here
	pass

func _input_event(event):
	self.get_node("/root/game").references["inputController"]._input(event,self,"button")
