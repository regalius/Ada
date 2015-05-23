
extends ScrollContainer

func _ready():
	# Initialization here
#	self.get_node("_v_scroll").set_opacity(0)
	pass

func _input_event(event):
	self.get_node("/root/game").references["inputController"]._input(event,self,"pieceContainerScroll")
