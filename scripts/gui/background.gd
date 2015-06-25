
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
	self.get_node("baloon_right").hide()
	self.get_node("baloon_bot").hide()
	self.get_node("baloon_top").hide()
	self.get_node("baloon_left").hide()
	self.get_node("baloon").hide()
	if what == "Baloon":
		self.get_node("baloon").show()
	elif what == "BaloonRight":
		self.get_node("baloon_right").show()
	elif what == "BaloonLeft":
		self.get_node("baloon_left").show()	
	elif what == "BaloonTop":
		self.get_node("baloon_top").show()
	elif what == "BaloonBot":
		self.get_node("baloon_bot").show()

	style = what
