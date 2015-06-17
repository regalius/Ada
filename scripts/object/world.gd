
extends Control

# member variables here, example:
# var a=2
# var b="textvar"

var references={}

func _ready():
	# Initialization here
	self.initReferences()
	pass

func initReferences():
	references["bg"] = self.get_node("bg/bg")
	self.get_node("animation").play("background")
func showBackground(state):
	if state:
		references["bg"].show()
	else:
		references["bg"].hide()