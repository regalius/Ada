
extends Control

# member variables here, example:
# var a=2
# var b="textvar"

var containerTitle = ""
var references = {
	"container" : "",
	"titleLbl" : ""
}

func _ready():
	# Initialization here
	initReferences()
	pass

func initReferences():
	references["container"] = self.get_node("levelcontainer")
	references["titleLbl"] = self.get_node("levelcontainer_title")

func setTitle(title):
	containerTitle = title
	references["titleLbl"].set_text(title)