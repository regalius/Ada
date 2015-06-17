
extends Control

export var style = "Default"

# member variables here, example:
# var a=2
# var b="textvar"

func _ready():
	# Initialization here
	self.changeStyle(style)
	pass

func changeStyle(what):
	if what == "Default":
		self.get_node("baloon").hide()
	elif what == "Baloon":
		self.get_node("baloon").show()
	style = what
