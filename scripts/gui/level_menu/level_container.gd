
extends Control

# member variables here, example:
# var a=2
# var b="textvar"

var containerTitle = ""
var references = {
	"container" : "",
	"titleLbl" : ""
}

var currents={
	"title":"",
	"index":""
}

func _ready():
	# Initialization here
	pass

func init(index,title):
	self.initReferences()
	self.setIndex(index)
	self.setTitle(title)

func initReferences():
	references["container"] = self.get_node("levelcontainer")
	references["titleLbl"] = self.get_node("levelcontainer_title")

func setIndex(index):
	currents["index"] = index
	
func setTitle(title):
	currents["title"] = title
	references["titleLbl"].set_text(title)
	
func getIndex():
	return currents["index"]
	
func getTitle():
	return currents["title"]
